FROM originate/exosphere-base

RUN npm install -g livescript

# These steps ensure that npm install is only run when package.json changes
ADD ./package.json /tmp/package.json
RUN cd /tmp && npm install
RUN mkdir /exosphere-users-service && cp -a /tmp/node_modules /exosphere-users-service

WORKDIR /exosphere-users-service
ADD . /exosphere-users-service
