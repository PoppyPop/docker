FROM busybox

ADD webui-aria2 /usr/html

EXPOSE 8080

CMD ["/bin/busybox","httpd","-f","-p","8080","-h","/usr/html"]