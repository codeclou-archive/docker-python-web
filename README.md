# docker-python-web

[![](https://codeclou.github.io/doc/badges/generated/docker-image-size-20.svg)](https://hub.docker.com/r/codeclou/docker-python-web/tags/) [![](https://codeclou.github.io/doc/badges/generated/docker-from-alpine-3.5.svg)](https://alpinelinux.org/) [![](https://codeclou.github.io/doc/badges/generated/docker-run-as-non-root.svg)](https://docs.docker.com/engine/reference/builder/#/user)

Docker-Image to run python webapps mounted as volume.

-----

&nbsp;

### Prerequisites

 * Runs as non-root with fixed UID 10777 and GID 10777. See [howto prepare volume permissions](https://github.com/codeclou/doc/blob/master/docker/README.md).
 * See [howto use SystemD for named Docker-Containers and system startup](https://github.com/codeclou/doc/blob/master/docker/README.md).


&nbsp;

-----

### Usage

Run the example-app like so.

```bash
docker run \
    -i -t \
    -v $(pwd)/example-app/:/pyapp/web \
    -v $(pwd)/data/:/pyapp/data \
    -p 8877:8000 \
    codeclou/docker-python-web:latest
```
Now go to http://localhost:8877 and see your app.
Note: Depending on how many dependencies you install, it might take some time until the server starts up.
You can write to `/pyapp/data/*` from your application.

----

Run a commandline app like so

```bash
docker run \
    -i -t \
    -v $(pwd)/example-cli/:/pyapp/web \
    -v $(pwd)/data/:/pyapp/data \
    codeclou/docker-python-web:latest \
    python cli.py
```


 
&nbsp;

-----

### Application Requirements

See the [example-app](./example-app) and abide the following **conventions** for your application:

 * Have a `requirements.txt` in the root of your project defining your dependencies
 * Have a `app.py` in the root of your project that starts a server on 8000 and listens on `0.0.0.0` 
 * Include the following line in your app to fetch the libs from `extlibs` dir
   * `sys.path.append(os.path.dirname(os.path.realpath(__file__)) + "/extlibs/")`


-----
&nbsp;

### License, Liability & Support

 * [![](https://codeclou.github.io/doc/docker-warranty-notice.svg?v1)](https://github.com/codeclou/docker-python-web/blob/master/LICENSE.md)
 * Dockerfile and Image is provided under [MIT License](https://github.com/codeclou/docker-python-web/blob/master/LICENSE.md)
