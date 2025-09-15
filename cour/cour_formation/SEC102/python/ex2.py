
import requests


url = "http://192.168.10.120/index.php?id="
#url = "http://localhost/?id="

for i in range(1,6): 
    r = requests.get(url + str(i))
    print(str(i) + ") " + str(r.content[:30]))

i = 1
while i <= 5:
    r = requests.get(url + str(i))
    print(str(i) + ") " + str(r.content[:30]))
    i += 1
