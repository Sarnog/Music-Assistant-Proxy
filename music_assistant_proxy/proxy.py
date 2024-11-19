import asyncio
import websockets
import argparse
from aiohttp import web
import logging

logging.basicConfig(level=logging.INFO)
logger = logging.getLogger(__name__)

class MusicAssistantProxy:
    def __init__(self, server_ip, server_port):
        self.server_ip = server_ip
        self.server_port = server_port
        self.ws_server_url = f"ws://{server_ip}:{server_port}/ws"
        
    async def proxy_websocket(self, websocket, path):
        try:
            async with websockets.connect(self.ws_server_url) as ws_server:
                # Handle bidirectional communication
                await asyncio.gather(
                    self.forward_messages(websocket, ws_server),
                    self.forward_messages(ws_server, websocket)
                )
        except Exception as e:
            logger.error(f"Verbindingsfout: {str(e)}")

    async def forward_messages(self, source, destination):
        try:
            async for message in source:
                await destination.send(message)
        except Exception as e:
            logger.error(f"Doorstuur fout: {str(e)}")

    async def start_server(self):
        async with websockets.serve(self.proxy_websocket, "0.0.0.0", 8096):
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
