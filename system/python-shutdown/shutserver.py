from http.server import HTTPServer, BaseHTTPRequestHandler
import os

class SimpleHTTPRequestHandler(BaseHTTPRequestHandler):

    def do_GET(self):
        if self.path=="/poweroff":
          self.send_response(200)
          self.end_headers()
          self.wfile.write(b'Shutdown !')
          os.system("sudo poweroff")
        else:
          self.send_response(500)
          self.end_headers()

httpd = HTTPServer(('0.0.0.0', 8000), SimpleHTTPRequestHandler)
httpd.serve_forever()
