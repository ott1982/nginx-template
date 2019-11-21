# How to get self-renewed Let's Encrypt certificate by Docker-compose

Let's Encrypt is a known certificates provider. These certificates tends to expire each 2 months. 

Let's encrypt offers the possibility of renew those certificates but...

**...how can we automate this task?**

# Requirements

* **Ubuntu** 16.04.
* Opened ports: **80** and **443**.
* Domain's name (published in DNS's). It's going to use .
* **Docker** version 19.03.4, build 9013bf583a.
* **docker-compose** version 1.24.1, build 4667896b.

# Guideline

We assume that:

* Our application is called **kontexting**.
* Our domain name is **cert.kontexting.com**.

Steps:

1. Get directories struct like this:

```
sudo mkdir /opt/kontexting
sudo chmod 777 /opt/kontexting
mkdir -p /opt/kontexting/nginx/html
mkdir -p /opt/kontexting/nginx/conf.d
mkdir -p /opt/kontexting/certbot/conf
mkdir -p /opt/kontexting/certbot/www
```

2. Get docke-compose.yml file.

```
touch /opt/kontexting/docker-compose.yml
```

3. Place somthenig like this to docker-compose.yml:

```
version: '3'
services:

  nginx:
    image: nginx
    ports:
      - "80:80"
      - "443:443"
    volumes:
      - ./nginx/conf.d:/etc/nginx/conf.d
      - ./nginx/html:/usr/share/nginx/html
      - ./certbot/conf:/etc/letsencrypt
      - ./certbot/www:/var/www/certbot
    command: "/bin/sh -c 'while :; do sleep 6h & wait $${!}; nginx -s reload; done & nginx -g \"daemon off;\"'"

  certbot:
    image: certbot/certbot
    volumes:
      - ./certbot/conf:/etc/letsencrypt
      - ./certbot/www:/var/www/certbot
    entrypoint: "/bin/sh -c 'trap exit TERM; while :; do certbot renew; sleep 12h & wait $${!}; done;'"
```

4. Create NGINX configuration file:

```
touch /opt/kontexting/nginx/conf.d/default.conf
```

5. Place following content to default.conf:

```
server {
    listen 80;
    server_name cert.kontexting.com;
    access_log /dev/stdout;

    location / {
        return 301 https://$host$request_uri;
    }

    location /.well-known/acme-challenge/ {
        root /var/www/certbot;
    } 
}

server {
    listen 443 ssl;
    server_name cert.kontexting.com;
    access_log /dev/stdout;
    ssl_certificate /etc/letsencrypt/live/cert.kontexting.com/fullchain.pem;
    ssl_certificate_key /etc/letsencrypt/live/cert.kontexting.com/privkey.pem;
    include /etc/letsencrypt/options-ssl-nginx.conf;
    ssl_dhparam /etc/letsencrypt/ssl-dhparams.pem;
    
    location / {
        root   /usr/share/nginx/html;
        index  index.html index.htm;
    }
}

```

*Notice that:*

* **ssl_certificate /etc/letsencrypt/live/cert.kontexting.com/fullchain.pem;** is static content.
* **ssl_certificate_key /etc/letsencrypt/live/cert.kontexting.com/privkey.pem;** is static content.
* **include /etc/letsencrypt/options-ssl-nginx.conf;**  is static content.
* **ssl_dhparam /etc/letsencrypt/ssl-dhparams.pem;**  is static content.
* **/.well-known/acme-challenge/** context on port 80 is required by Let's Encrypt.
* **cert.kontexting.com** server name have to be replaced by yours.

6. Place some index.html to /opt/kontexting/nginx/html:

```
echo "<h1>Hello world!</h1>" > /opt/kontexting/nginx/html/index.html
```

7. Get init-letsencrypt.sh and place it in the docker-compose.yml's directory.

```
curl -L https://raw.githubusercontent.com/wmnnd/nginx-certbot/master/init-letsencrypt.sh > /opt/kontexting/init-letsencrypt.sh
```

8. Edit **inti-letsencrypt.sh** and replace following content:

```
domains=(cert.kontexting.com)
rsa_key_size=4096
data_path="./certbot"
email="oriol.tristany@eurecat.org" # Adding a valid address is strongly recommended
staging=0 # Set to 1 if you're testing your setup to avoid hitting request limits
```

9. Execute script (it will create selfsigned certificates):

```
sudo ./init-letsencrypt.sh
```

10. Make up the compose file:

```
docker-compose up -d
```

11. Check the self-signed certificate. Navigate to "https://cert.kontexting.com". **Not secure** certificate should appear.

12. Run the script again:

```
sudo ./init-letsencrypt.sh
```

13. Check the certificate. Navigate to "https://cert.kontexting.com" again. **Secure** certificate should appear.

14. Enjoy it.

# Bibliography

* [Docker](https://docs.docker.com/v17.12/install/linux/docker-ce/ubuntu/).
* [Docker-compose](https://docs.docker.com/compose/install/).
* [Medium article](https://medium.com/@pentacent/nginx-and-lets-encrypt-with-docker-in-less-than-5-minutes-b4b8a60d3a71).