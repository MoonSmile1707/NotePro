FROM python:3.6.8-alpine3.9

USER root
# install git-core
# RUN apk add git git-lfs --update-cache --repository http://dl-3.alpinelinux.org/alpine/edge/testing/

#set up for build
RUN mkdir -p /usr/src/env
WORKDIR /usr/src/env

COPY *.txt .
RUN pip install -r *.txt


#set up for deploy
RUN mkdir -p /usr/src/docs
WORKDIR /usr/src/docs
ADD local.env .env

# add port
EXPOSE 9091

# set up for development
ENTRYPOINT ["mkdocs"]
CMD ["serve", "--dev-addr=0.0.0.0:9091"]