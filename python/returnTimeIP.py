import json
import os
from datetime import datetime
#from flask import Flask, request, jsonify


#get IP address of visitors using Flask for Python
#https://stackoverflow.com/questions/3759981/get-ip-address-of-visitors-using-flask-for-python

''' 
app = Flask(__name__)
@app.route("/get_my_ip", methods=['GET'])
def get_my_ip():
    return jsonify({'ip': request.remote_addr}), 200

#app.run(host="0.0.0.0", port=8080)
#through error if other methods
'''
#get current time
def get_my_time():
    timestamp = datetime.now().strftime('%Y-%m-%d %H:%M:%S')
    results = f'Time: {timestamp}'
    return results

#print(get_my_time()) #,get_my_ip())

def lambda_handler(event,context):
    json_region = os.environ['AWS_REGION']
    results1 = get_my_time()
    #results2 = get_my_ip()
    #used to test locally
    print(json.dumps(results1)) #, results2))
   

if __name__ == '__main__':
    lambda_handler(0, 0)  