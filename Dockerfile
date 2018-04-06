FROM odota/parser:latest

ADD . .
RUN chmod +x launch.sh

CMD ['/bin/sh', '-c', 'launch.sh']