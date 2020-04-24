from flask import Flask, request, jsonify

from src import app


@app.route('/')
def hello_world():
    return """
        Simple response from Flask running inside uWSGI, 
        which is running within nGINX, 
        which is hosted inside a Docker image!
    """


@app.route('/echo_request')
def echo_request():
    return jsonify(dict(request.headers))

