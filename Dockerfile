FROM node:6.5.0-wheezy

RUN apt-get update -y && apt-get install -y libtool autoconf automake make g++ uuid-dev wget mongodb
RUN wget http://download.zeromq.org/zeromq-4.1.4.tar.gz && tar -xvf zeromq-4.1.4.tar.gz && cd zeromq-* && ./configure --without-libsodium && make install && ldconfig && cd .. && rm -rf zeromq*

RUN npm install -g LiveScript && npm install -g cucumber

ADD . /exosphere-users-service
WORKDIR /exosphere-users-service
ENV PATH=./node_modules/.bin:./bin:$PATH
ENV EXOCOM_PORT=4000
ENV EXORELAY_PORT=4001
ENV SERVICE_NAME=users

RUN mongod --fork --logpath /var/log/mongod.log
EXPOSE 27017
RUN setup
CMD ["/bin/bash"]
