#docker Ubooquity (raspberry pi)

## Description:
Ubooquity is a free, lightweight and easy-to-use home server for your comics and ebooks.  
Use it to access your files from anywhere, with a tablet, an e-reader, a phone or a computer.

## Manual build:

```
git clone https://github.com/Sidirius/docker-pi-ubooquity.git 
cd docker-pi-ubooquity
docker build --rm -t sidirius/docker-pi-ubooquity . 
```

## Volumes:

#### `/config`

Location of configurations files, logs, and theme files.

### `/media`

Location of files you wish to share via Ubooquity.

## Environment variables:

### `UBOOQUITY_PORT`

Port to be used by Ubooquity default port is 8085.


## Instructions:

* Run the docker command.

## Docker run command:

```
docker run --name ubooquity -d -p 8085:8085 -v /*ubooquity_cofing_dir*:/config -v /*your_media_location*:/media sidirius/docker-pi-ubooquity

```
