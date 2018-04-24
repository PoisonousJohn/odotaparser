FROM odota/parser:latest

RUN apt-get update
RUN apt-get install --assume-yes aria2

ADD job.sh job.sh
ADD launch.sh launch.sh
RUN chmod +x launch.sh

CMD ["/bin/bash", "launch.sh"]
