FROM odota/parser:latest

RUN apt-get update
RUN apt-get install --assume-yes postgresql-client
RUN apt-get install --assume-yes python-psycopg2

ADD launch.sh launch.sh
ADD insert.py insert.py
RUN chmod +x launch.sh

CMD ['/bin/sh', '-c', 'launch.sh']
