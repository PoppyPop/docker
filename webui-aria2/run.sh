
#!/bin/bash
#

docker stop webui-aria2
docker rm webui-aria2
docker run -d --restart=always -v /home/jdownloader/Downloads:/data -p 6800:6800 -p 9100:8080 --name=webui-aria2 video3/webui-aria2

