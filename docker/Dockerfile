FROM python:3.6.8-alpine3.9

USER root
#set up for build
RUN mkdir /usr/env
WORKDIR /usr/env
COPY requirements.txt requirements.txt
RUN pip install -r requirements.txt


#set up for deploy
RUN mkdir -p /usr/docs
WORKDIR /usr/docs

# add port
EXPOSE 9091

# set up for development
# ENTRYPOINT ["mkdocs"]
# CMD ["serve", "--dev-addr=0.0.0.0:9091"]