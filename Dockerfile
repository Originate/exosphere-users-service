FROM node:6.5.0-wheezy

# Install MongoDB and ZeroMQ
RUN apt-get update -y && apt-get install -y libtool autoconf automake make g++ uuid-dev wget mongodb
RUN wget http://download.zeromq.org/zeromq-4.1.4.tar.gz && tar -xvf zeromq-4.1.4.tar.gz && cd zeromq-* && ./configure --without-libsodium && make install && ldconfig && cd .. && rm -rf zeromq*

# Install LiveScript and Cucumber
RUN npm install -g LiveScript && npm install -g cucumber

# Get users service
ADD . /exosphere-users-service
WORKDIR /exosphere-users-service


# Set environment variables
ENV PATH=./node_modules/.bin:./bin:$PATH
ENV EXOCOM_PORT=4000
EXPOSE 4000
ENV EXORELAY_PORT=4001
EXPOSE 4001
ENV SERVICE_NAME=users

# Run setup script for users service
RUN setup

# Mount MongoDB storage location and expose port
VOLUME ["/data/db"]
EXPOSE 27017

CMD ["sh", "docker-run.sh"]
