
# Dynamo-Docker

This is a dockerized full node for DYNAMO coin. The intent for this project is to make running a full node more accessible for people to use for a dedicated mining node or contribute to the network. 



## Run Locally

Clone the project

```bash
  git clone https://github.com/Daedalus-/Dynamo-Docker.git
```

Go to the project directory

```bash
  cd Dynamo-Docker
```

Edit the `Dockerfile` to set your desired `dynamo.conf` settings.

*DO NOT USE THE DEFAULT USER / PASSWORD / NFTDBKEY*
```bash
echo "txindex=0" >> ~/.dynamo/dynamo.conf && \
echo "rpcbind=0.0.0.0" >> ~/.dynamo/dynamo.conf && \
echo "rpcport=6433" >> ~/.dynamo/dynamo.conf && \
echo "rpcuser=dynamo" >> ~/.dynamo/dynamo.conf && \
echo "rpcpassword=123456" >> ~/.dynamo/dynamo.conf && \
echo "rpcallowip=0.0.0.0/0" >> ~/.dynamo/dynamo.conf && \
echo "fallbackfee=0.01" >> ~/.dynamo/dynamo.conf && \
echo "nftdbkey=supersecretstring" >> ~/.dynamo/dynamo.conf && \
echo "nftnode=true" >> ~/.dynamo/dynamo.conf && \
```

Build the image - During the build this will check out the latest `dynamo-core` source and compile it. This process will require about 2G of space for the build process. The resulting image will be about 500MB.

```bash
  docker build .
```

This will list all images, get the image ID for your new image.

```bash
  docker images

REPOSITORY                           TAG                                                     IMAGE ID       CREATED          SIZE
<none>                               <none>                                                  5b0633fd8fdd   21 minutes ago   502MB
```

Tag the new image with the following syntax: `docker tag <Image ID> <tag>`

```bash
  docker tag 5b0633fd8fdd daedalus/dynamo
```

Run `docker images` again to see your newly tagged image.

```bash
REPOSITORY                           TAG                                                     IMAGE ID       CREATED          SIZE
daedalus/dynamo                      latest                                                  5b0633fd8fdd   24 minutes ago   502MB
```

You now need to make a data directory where the node will save its config file as well as all of the blockchain, NFT data, etc. (Make sure it has enough space.)

```bash
  mkdir /data/dynamo
```

You are now ready to run the container for the first time.

```bash
  docker run -v /data/dynamo/:/root/.dynamo/ -d -p 6432:6432/tcp -p 6433:6433/tcp daedalus/dynamo
```

To check that the container is running, use the `docker ps` command. 

```bash
CONTAINER ID   IMAGE             COMMAND         CREATED         STATUS         PORTS                                                           NAMES
fc5bf998dbba   daedalus/dynamo   "dynamo-core"   5 seconds ago   Up 5 seconds   0.0.0.0:6432-6433->6432-6433/tcp, :::6432-6433->6432-6433/tcp   intelligent_rubin
```

Take a look in your data directory and make sure files are being created there.

```bash
  ls -la /data/dynamo
```

You can also watch the `debug.log` to see the live output. (CTRL+C to stop)

```bash
  tail -f /data/dynamo/debug.log
```