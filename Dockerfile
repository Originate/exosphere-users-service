FROM originate/exosphere-base

RUN npm install -g LiveScript

ADD ./package.json /tmp/package.json
RUN cd /tmp && npm install
RUN mkdir /exosphere-users-service && cp -a /tmp/node_modules /exosphere-users-service/

WORKDIR /exosphere-users-service
ADD . /exosphere-users-service

RUN export PATH=./bin:./node_modules/.bin:$PATH
