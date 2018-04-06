FROM odota/parser:latest

RUN apt-get update
RUN apt-get install --assume-yes postgresql-client

ADD . .
RUN chmod +x launch.sh

CMD ['/bin/sh', '-c', 'launch.sh']