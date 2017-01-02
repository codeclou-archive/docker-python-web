# docker-python-web

[![](https://codeclou.github.io/doc/docker-image-size-19.svg)](https://hub.docker.com/r/codeclou/docker-python-web/tags/) [![](https://codeclou.github.io/doc/docker-from-alpine.svg)](https://alpinelinux.org/) [![](https://codeclou.github.io/doc/docker-run-as-non-root.svg)](https://docs.docker.com/engine/reference/builder/#/user)

Docker Container that starts a python webapp mounted as volume.


![](https://codeclou.github.io/doc/docker-warranty.svg?v5)

-----

### Usage

You can write to `/pyapp/data/*` from your application.

**Users and Permissions**

On the host system you should add a user and group with the following UID and GID values to have them
mapped correctly on volume file permissions.

 * User pyworker with UID 10777 
 * Group pyworker with GID 10777
 * Create the empty volume-dirs and assign them with `chown` to pyworker 

----

**Interactive**

```bash
docker run \
    -i -t \
    -v $(pwd)/example-app/:/pyapp/web \
    -v $(pwd)/data/:/pyapp/data \
    -p 8877:8000 \
    codeclou/docker-python-web:latest
```

You can write to `/pyapp/data/*` from your application.

----

**Interactive Execute Python Commandline**

```bash
docker run \
    -i -t \
    -v $(pwd)/example-cli/:/pyapp/web \
    -v $(pwd)/data/:/pyapp/data \
    codeclou/docker-python-web:latest \
    python cli.py
```

----

**Named Docker Container**


```bash
docker create \
    --name myapp \
    -v $(pwd)/example-app/:/pyapp/web \
    -v $(pwd)/data/:/pyapp/data \
    -p 8877:8000 \
    codeclou/docker-python-web:latest

docker start myapp
```

Now go to http://localhost:8877 and see your app. 
(Note: Depending on how many dependencies you install, it might take some time until the server starts up)

-----

### Prerequisites

See the [example-app](./example-app) and abide the following **conventions**:

 * Have a `requirements.txt` in the root of your project defining your dependencies
 * Have a `app.py` in the root of your project that starts a server on 8000 and listens on `0.0.0.0` 
 * Include the following line in your app to fetch the libs from `extlibs` dir
   * `sys.path.append(os.path.dirname(os.path.realpath(__file__)) + "/extlibs/")`

-----

### Service with systemd (Ubuntu 16.04)

Create `/etc/systemd/system/myapp.service`

```
[Unit]
Description=myapp container
Requires=docker.service
After=docker.service

[Service]
Restart=always
ExecStart=/usr/bin/docker start -a myapp
ExecStop=/usr/bin/docker stop -t 2 myapp

[Install]
WantedBy=default.target
```

Reload Daemon, Start Docker Image and add to System Startup

```
systemctl daemon-reload
systemctl start myapp.service
systemctl enable myapp.service
```

----


### License

  * Dockerfile and Image is provided under [MIT License](https://github.com/codeclou/docker-python-web/blob/master/LICENSE.md)
