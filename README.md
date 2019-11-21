# NGINX configguration template

Template for fast NGINX deployment.

# Table of contents

1. [Objectives](#objectives).
2. [Architecture](#architecture).
3. [Technological stack](#technological-stack)
4. [Structure](#structure).
5. [Tools](#tools).
6. [Dependencies](#management).
7. [Documentation](#documentation).
8. [Appendix](#appendix).
9. [Bibliography](#bibliography).

# Objectives

Publish and learn NGINX configuration in order to be used as:

1. Web server (HTTPS, expose static content, domain name).
2. Let's encrypt.
3. Cache provider.
4. Reverse proxy.
5. PHP server.
6. Reverse proxy X-Forwarded headers.
7. Basic authorization (file).
8. Basic authorization (internal request to another service).

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

#table-of-contents)

# Dependencies

External dependences (into planned system).

[Return](#table-of-contents)

# Documentation

Links to support your knowledge about the project.

Wikipedia links...

[Return](#table-of-contents)

# Appendix

Code snippets...

## How to create Self signed PEM files

From project root, execute:

```sh
openssl req -x509 -nodes -days 99999 -newkey rsa:2048 -keyout ssl/private/my-certificate.key -out ssl/certs/my-certificate.crt
sudo chmod 644 ssl/certs/*.crt
sudo chmod 640 ssl/private/*.key
```

[Return](#table-of-contents)

# Bibliography

External used references.

* [Readme template](https://github.com/ott1982/readme).

[Return](#table-of-contents)