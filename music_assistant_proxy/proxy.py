import asyncio
import websockets
import argparse
from aiohttp import web
import logging
import aiohttp

logging.basicConfig(level=logging.INFO)
logger = logging.getLogger(__name__)

class MusicAssistantProxy:
    def __init__(self, server_ip, server_port):
        self.server_ip = server_ip
        self.server_port = server_port
        self.ws_server_url = f"ws://{server_ip}:{server_port}/ws"
        self.http_server_url = f"http://{server_ip}:{server_port}"
        
    async def handle_websocket(self, request):
        ws = web.WebSocketResponse()
        await ws.prepare(request)
        
        try:
            async with aiohttp.ClientSession() as session:
                async with session.ws_connect(self.ws_server_url) as ws_server:
                    # Handle bidirectional communication
                    await asyncio.gather(
                        self.forward_ws_messages(ws, ws_server),
                        self.forward_ws_messages(ws_server, ws)
                    )
        except Exception as e:
            logger.error(f"WebSocket fout: {str(e)}")
        
        return ws

    async def handle_http(self, request):
        path = request.path
        method = request.method
        headers = dict(request.headers)
        
        try:
            async with aiohttp.ClientSession() as session:
                async with session.request(
                    method,
                    f"{self.http_server_url}{path}",
                    headers=headers,
                    data=await request.read()
                ) as response:
                    return web.Response(
                        body=await response.read(),
                        status=response.status,
                        headers=response.headers
                    )
        except Exception as e:
            logger.error(f"HTTP fout: {str(e)}")
            return web.Response(status=500, text=str(e))

    async def forward_ws_messages(self, source, destination):
        async for msg in source:
            if msg.type == aiohttp.WSMsgType.TEXT:
                await destination.send_str(msg.data)
            elif msg.type == aiohttp.WSMsgType.BINARY:
                await destination.send_bytes(msg.data)
            elif msg.type == aiohttp.WSMsgType.ERROR:
                logger.error(f"WebSocket fout bij doorsturen: {msg.data}")
                break

    async def start_server(self):
        app = web.Application()
        app.router.add_get('/ws', self.handle_websocket)
        app.router.add_route('*', '/{tail:.*}', self.handle_http)
        
        runner = web.AppRunner(app)
        await runner.setup()
        site = web.TCPSite(runner, '0.0.0.0', 8096)
        await site.start()
        
        logger.info(f"Proxy server draait op http://0.0.0.0:8096")
        await asyncio.Future()  # run forever

def main():
    parser = argparse.ArgumentParser(description='Music Assistant Proxy')
    parser.add_argument('--server-ip', required=True, help='Server IP adres')
    parser.add_argument('--server-port', required=True, help='Server poort')
    args = parser.parse_args()

    proxy = MusicAssistantProxy(args.server_ip, args.server_port)
    
    logger.info(f"Start proxy naar {args.server_ip}:{args.server_port}")
    asyncio.run(proxy.start_server())

if __name__ == "__main__":
    main()
