#!/usr/bin/env python3

import http.server
from http.server import HTTPServer, BaseHTTPRequestHandler
import socketserver
import os

PORT = 8080
DIRECTORY = "docs"

def add_html(path):
    if path == "/":
        return path

    path_list = path.split("/")
    _, ext = os.path.splitext(path_list[-1])
    if ext == "":
        path_list[-1] += ".html"

    return "/".join(path_list)

class Handler(http.server.SimpleHTTPRequestHandler):
    def __init__(self, *args, **kwargs):
        super().__init__(*args, directory=DIRECTORY, **kwargs)

    def do_GET(self):
        self.path = add_html(self.path)
        super().do_GET()

with socketserver.TCPServer(("", PORT), Handler) as httpd:
    print(f"running test server at http://localhost:{PORT}")
    httpd.serve_forever()
