FROM ubuntu:bionic

EXPOSE 6432 6433

VOLUME dynamo 

WORKDIR /dynamo

RUN apt-get update && \
    apt-get install -y build-essential libtool autotools-dev automake pkg-config bsdmainutils python3 && \
    apt-get install -y libevent-dev libboost-dev libboost-system-dev libboost-filesystem-dev libboost-test-dev libdb++-dev && \
    apt-get install -y git && \
    mkdir ~/.dynamo && \
    git clone https://github.com/dynamofoundation/dynamo-core.git && \
    echo "server=1" > ~/.dynamo/dynamo.conf && \
    echo "daemon=0" >> ~/.dynamo/dynamo.conf && \
    echo "txindex=0" >> ~/.dynamo/dynamo.conf && \
    echo "rpcbind=0.0.0.0" >> ~/.dynamo/dynamo.conf && \
    echo "rpcport=6433" >> ~/.dynamo/dynamo.conf && \
    echo "rpcuser=dynamo" >> ~/.dynamo/dynamo.conf && \
    echo "rpcpassword=123456" >> ~/.dynamo/dynamo.conf && \
    echo "rpcallowip=0.0.0.0/0" >> ~/.dynamo/dynamo.conf && \
    echo "fallbackfee=0.01" >> ~/.dynamo/dynamo.conf && \
    echo "nftdbkey=supersecretstring" >> ~/.dynamo/dynamo.conf && \
    echo "nftnode=true" >> ~/.dynamo/dynamo.conf && \
    cd dynamo-core && \
    echo "#!/bin/bash" > make-dynamo.sh && \
    echo "/usr/bin/make " >> make-dynamo.sh && \
    echo "exit 0" >> make-dynamo.sh && \
    chmod 755 ./make-dynamo.sh && \
    ./autogen.sh && \
    ./configure --with-incompatible-bdb && \
    ./make-dynamo.sh || echo "failed!" && \
    cp ./src/bitcoind /bin/dynamo-core && \
    apt-get clean && rm -rf /var/lib/apt/lists/* 
 
	
	
CMD ["dynamo-core"]

