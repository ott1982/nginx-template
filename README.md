# NGINX configguration template

Template for fast NGINX deployment.

# Table of contents

1. [Objectives](#objectives).
2. [Architecture](#architecture).]
3. [Technological stack](#technological-stack)
4. [Structure](#structure).
5. [Tools](#tools).
6. [Environment](#environment).
   1. [Development](#development).
   2. [Production](#production).
7. [Dependencies](#management).
8. [Management](#management).
   1. [Collaborators](#collaborators).
   2. [Kanban](#kanban).
   3. [Task list](#task-list).
9. [Continious Integration](#continious-integration).
10. [Sonar](#sonar).
11. [Tagging](#tagging).
12. [Documentation](#documentation).
13. [Appendix](#appendix).
14. [Bibliography](#bibliography).

# Objectives

Publish and learn NGINX configuration in order to be used as:

1. Web server (HTTPS, expose static content, domain name).
2. Let's encrypt.
3. Cache provider.
4. Reverse proxy.
5. Reverse proxy X-Forwarded headers.
6. Basic authorization (file).
7. Basic authorization (internal request to another service).

[Return](#table-of-contents)

# Architecture

External point of view as a part of a system. 

Diagrams made by [Draw.io](https://draw.io)...

[Return](#table-of-contents)

# Technological stack

* Docker.
* Docker compose.

[Return](#table-of-contents)

# Structure

Directories list and their content:

* docker: 

* postman: 

* jmeter: 

* src: 

* sql: 

* data: 

* ...

[Return](#table-of-contents)

# Tools

Gradle tasks, Maven tasks, shellscripts, Flyway, Makefile, npm...

[Return](#table-of-contents)

# Environments

Accessibility:

| Name           | IP      | Opened ports                      | Notes |
| -------------- | ------- | --------------------------------- | ----- |
| Testing        | x.x.x.x | all.                              | -     |
| Integration    | x.x.x.x | 22 (ssh), 443 (https), 80 (http). | -     |
| Pre-production | x.x.x.x | 22 (ssh), 443 (https).            | -     |
| Production     | x.x.x.x | 22 (ssh), 443 (https).            | -     |

[Return](#table-of-contents)

## Development

Developer host.

### Build

```sh

```

[Return](#table-of-contents)

### Run

```sh

```

[Return](#table-of-contents)

### Deploy

```sh

```

[Return](#table-of-contents)

## Production

No developer host. 
Each deployment should follow same template.

### Build

```sh

```

[Return](#table-of-contents)

### Deploy

```sh

```

[Return](#table-of-contents)

# Dependencies

External dependences (into planned system).

[Return](#table-of-contents)

# Management

## Collaborators

| Name    | Role             | Company         | e-mail              | Phone                  |
| ------- | ---------------- | --------------- | ------------------- | ---------------------- |
| My name | senior developer | Eurecat (Spain) | myemail@example.com | 99 999 99 99 99 (1234) |

[Return](#table-of-contents)

## Kanban

Link to.

[Return](#table-of-contents)

## Tasks list

Link to.

[Return](#table-of-contents)

# Continuos Integration

Jenkins jobs...

[Return](#table-of-contents)

# Sonar

?

[Return](#table-of-contents)

# Tagging

How can I get current version in a deployment?

[Return](#table-of-contents)

# Documentation

Links to support your knowledge about the project.

Wikipedia links...

[Return](#table-of-contents)

# Appendix

Code snippets...

[Return](#table-of-contents)

# Bibliography

External used references.

* [Readme template](https://github.com/ott1982/readme).

[Return](#table-of-contents)





# 







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

Certificate and key generation:

```sh
openssl req -x509 -nodes -days 99999 -newkey rsa:2048 -keyout ssl/private/my-certificate.key -out ssl/certs/my-certificate.crt
```

Public Certificate(s):

```sh
sudo chmod 644 /etc/ssl/certs/*.crt
```

Private Key(s):

```sh
sudo chmod 640 /etc/ssl/private/*.key
```

