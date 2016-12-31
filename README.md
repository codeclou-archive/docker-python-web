# docker-python-web

Docker Container that starts a python webapp mounted as volume.


![](https://codeclou.github.io/doc/docker-warranty.svg?v5)

-----

### Usage

Start a docker image with the command.

```bash
#
# CREATE NAMED CONTAINER
#
docker create \
    --name myapp \
    -v $(pwd)/example-app/:/opt/python/web \
    -p 8877:8000 \
    codeclou/docker-python-web:latest
    
#
# Start
#
docker start myapp

#
# OR: Run interactively
#
docker run \
    -i -t \
    -v $(pwd)/example-app/:/opt/python/web \
    -p 8866:8000 \
    codeclou/docker-python-web:latest
```

Now go to http://localhost:8877 and see your app. 
(Note: Depending on how many dependencies you install, it might take some time until the server starts up)

-----

### Prerequisites

See the [example-app](./example-app) and abide the following **conventions**:

 * Have a `requirements.txt` in the root of your project defining your dependencies
 * Have a `run.sh` in the root of your project that does two things
   * (1) Run `pip install --target=./extlibs -r requirements.txt`
   * (2) Run the app `python app.py` (in foreground as last command)
 * Include the following line in your app to fetch the libs from `extlibs` dir
   * `sys.path.append(os.path.dirname(os.path.realpath(__file__)) + "/extlibs/")`
 * Start your server on Port 8000 and have it listen on `0.0.0.0`

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
