from ensurepip import bootstrap
from flask import Flask, render_template, send_file, make_respose, url_for, Response
from flask import bootstrap
# from table_data import *

app = Flask(__name__)

@app.route('/')
def index():
    return render_template('index.html')
