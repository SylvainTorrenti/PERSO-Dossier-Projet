
import requests


url = "http://192.168.10.120/index.php?id="
#url = "http://localhost/?id="


proxy = {'http':'http://127.0.0.1:8080'}
headers = {'User-Agent':'mon user agent'}

for i in range(1,6): 
    r = requests.post(url + str(i), headers=headers, proxies=proxy)
    print(str(i) + ") " + str(r.content[:30]))

'''
i = 1
while i <= 5:
    r = requests.get(url + str(i))
    print(str(i) + ") " + str(r.content[:30]))
    i += 1
'''
