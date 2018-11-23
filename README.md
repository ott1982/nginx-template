# nginx-template

Template for fast NGINX deployment.

# Run

## Requirements

Our files are created for "nginx.edu" domain.

* Docker installed.


* myCA.key // phrase
* myCA.pem // nginx.edu (hostname)
* ssl.pass // phrase

## Execution

```
docker pull nginx:stable
docker rm -f edu.ngnix.container
docker run \
-p 443:443 \
-v $(pwd)/ssl/certs:/etc/ssl/certs:ro \
-v $(pwd)/logs:/var/log/nginx \
-v $(pwd)/nginx/nginx.conf:/etc/nginx/nginx.conf:ro \
-v $(pwd)/html:/usr/share/nginx/html:ro \
--name edu.ngnix.container \
-d \
nginx:stable
```

# Appendix

## HowTo create Self signed PEM files

Execute following commandline:

```
openssl genrsa -des3 -out myCA.key 2048
openssl req -x509 -new -nodes -key myCA.key -sha256 -days 9999 -out myCA.pem
echo "phrase" >> ssl.pass
```

Complete it for your own domain.

For self-signed certifcate, it must map your domain to your /etc/hosts as 127.0.0.1.

