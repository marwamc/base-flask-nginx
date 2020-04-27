# pyserver
a simple python (flask) webserver image

## how to setup and run
The `infra` sets up a nginx server on `0.0.0.0:8989`

The `src` directory contains the flask/python code. This is the fairy dust..

### Option 1: fork and clone this repo
Then simply run:
```bash
make start
make shell
make stop
```
In the cloned directory, add your python code to the `src` module following python best practices.
  
### Option 2: pull image from dockerhub
The `uwsgi.ini` file in the image presumes the following flask structure:
```
chdir=/app/pyserver
module=src.main
callable=app
```

#### 1. Create the following directory structure:
```
~/project2/src
~/project2/src/main.py
~/project2/src/views.py
```

Refer to the sample [main.py](./src/main.py) and [views.py](./src/views.py) for examples.

#### 2. Then run the following command inside `~/project2`
 ```bash
docker run --rm -v $(pwd)/src:/app/pyserver/src -p 8989:8989 --name pyserver_test marwamc/pyserver:latest 
```

# References

1. https://github.com/szelenka/openshift-prototype/tree/master/deployment

2. https://towardsdatascience.com/how-to-do-rapid-prototyping-with-flask-uwsgi-nginx-and-docker-on-openshift-f0ef144033cb

3. https://www.novixys.com/blog/python-web-application-docker-nginx-uwsgi/
