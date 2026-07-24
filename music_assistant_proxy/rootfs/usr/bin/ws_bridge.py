#!/usr/bin/env python3
"""WebSocket auth bridge for the Music Assistant Proxy add-on.

Sits between the Home Assistant Ingress (the browser) and a standalone Music
Assistant server, only for the ``/ws`` WebSocket. It authenticates the shared
Music Assistant connection up front with a long-lived token.

Why this is needed: behind Home Assistant Ingress the Music Assistant frontend
does not send a login; it just asks "who am I?" (``get_current_user``) and
expects the connection to already be authenticated by the ingress socket. That
only happens when Music Assistant itself runs as the Home Assistant add-on. For
a standalone server that check can never pass, so the frontend dead-ends on
"Failed to authenticate via Home Assistant Ingress".

This bridge authenticates the connection with the token before relaying any
browser message, so ``get_current_user`` succeeds and no login screen appears.
Everything else is relayed transparently in both directions.
"""

from __future__ import annotations

import asyncio
import json
import logging
import os

from aiohttp import ClientSession, WSMsgType, web

LOGGER = logging.getLogger("ws_bridge")

SERVER_HOST = os.environ.get("SERVER_HOST", "localhost")
SERVER_PORT = os.environ.get("SERVER_PORT", "8095")
MA_TOKEN = os.environ.get("MA_TOKEN", "").strip()
LISTEN_HOST = os.environ.get("BRIDGE_HOST", "127.0.0.1")
LISTEN_PORT = int(os.environ.get("BRIDGE_PORT", "8096"))

MA_WS_URL = f"ws://{SERVER_HOST}:{SERVER_PORT}/ws"

# message_id for our own auth command. The frontend uses an incrementing integer
# counter rendered as a string ("1", "2", ...), so this sentinel never collides.
PROXY_AUTH_ID = "__ma_proxy_auth__"


def _is_proxy_auth_response(data: str) -> bool:
    """Return True if this Music Assistant message is the reply to our own auth.

    Such a reply must not be forwarded to the browser (it never sent it).
    """
    try:
        parsed = json.loads(data)
    except (ValueError, TypeError):
        return False
    if not isinstance(parsed, dict) or parsed.get("message_id") != PROXY_AUTH_ID:
        return False
    if parsed.get("error") or parsed.get("error_code"):
        LOGGER.error("Token authentication with Music Assistant failed: %s", parsed)
    else:
        LOGGER.info("Music Assistant connection authenticated with the token")
    return True


async def handle_ws(request: web.Request) -> web.WebSocketResponse:
    """Bridge one browser WebSocket to the Music Assistant server."""
    browser_ws = web.WebSocketResponse(max_msg_size=0)
    await browser_ws.prepare(request)
    LOGGER.info("Browser connected; opening upstream connection to %s", MA_WS_URL)

    session = ClientSession()
    try:
        ma_ws = await session.ws_connect(MA_WS_URL, max_msg_size=0)
    except Exception as err:  # noqa: BLE001 - report and close cleanly
        LOGGER.error("Could not connect to Music Assistant (%s): %s", MA_WS_URL, err)
        await session.close()
        if not browser_ws.closed:
            await browser_ws.close()
        return browser_ws

    # Authenticate the shared connection with the token BEFORE relaying any
    # browser message, so it is authenticated by the time the frontend asks
    # get_current_user. Music Assistant processes messages in order, and this is
    # the first message on the upstream connection.
    if MA_TOKEN:
        await ma_ws.send_str(
            json.dumps(
                {
                    "command": "auth",
                    "message_id": PROXY_AUTH_ID,
                    "args": {
                        "token": MA_TOKEN,
                        "device_name": "Home Assistant Proxy",
                    },
                }
            )
        )

    async def browser_to_ma() -> None:
        async for msg in browser_ws:
            if msg.type == WSMsgType.TEXT:
                await ma_ws.send_str(msg.data)
            elif msg.type == WSMsgType.BINARY:
                await ma_ws.send_bytes(msg.data)
            else:  # CLOSE / CLOSING / ERROR
                break
        if not ma_ws.closed:
            await ma_ws.close()

    async def ma_to_browser() -> None:
        async for msg in ma_ws:
            if msg.type == WSMsgType.TEXT:
                # Swallow the reply to our own auth command; the browser never
                # sent it and must not see it. The cheap substring check avoids
                # JSON-parsing every (potentially large) message.
                if (
                    MA_TOKEN
                    and PROXY_AUTH_ID in msg.data
                    and _is_proxy_auth_response(msg.data)
                ):
                    continue
                await browser_ws.send_str(msg.data)
            elif msg.type == WSMsgType.BINARY:
                await browser_ws.send_bytes(msg.data)
            else:  # CLOSE / CLOSING / ERROR
                break
        if not browser_ws.closed:
            await browser_ws.close()

    try:
        await asyncio.gather(browser_to_ma(), ma_to_browser())
    except Exception as err:  # noqa: BLE001 - disconnect races are expected
        LOGGER.debug("Relay ended: %s", err)
    finally:
        if not ma_ws.closed:
            await ma_ws.close()
        await session.close()
        LOGGER.info("Connection closed")
    return browser_ws


def main() -> None:
    logging.basicConfig(level=logging.INFO, format="[ws-bridge] %(levelname)s: %(message)s")
    if not MA_TOKEN:
        LOGGER.warning(
            "No Music Assistant token set: the bridge only relays traffic, so the "
            "login screen behind Home Assistant Ingress will NOT be bypassed. "
            "Set the 'Music Assistant token' option to enable automatic login."
        )
    app = web.Application()
    app.router.add_get("/ws", handle_ws)
    LOGGER.info("WebSocket auth bridge listening on %s:%s", LISTEN_HOST, LISTEN_PORT)
    web.run_app(app, host=LISTEN_HOST, port=LISTEN_PORT, print=None)


if __name__ == "__main__":
    main()
