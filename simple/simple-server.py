#!/usr/bin/env python3.6

# Based largely on https://www.afternerd.com/blog/python-http-server/

import http.server
import socketserver

PORT = 8000

the_handler = http.server.SimpleHTTPRequestHandler

socketserver.TCPServer.allow_reuse_address = True

with socketserver.TCPServer(("", PORT), the_handler) as httpd:
	print("serving at port", PORT)
	httpd.serve_forever()

