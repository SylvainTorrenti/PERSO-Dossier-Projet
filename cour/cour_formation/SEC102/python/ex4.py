
from scapy import *

paquet = Ether()/IP(dst="192.168.10.120")/TCP()/"GET /index.php?id=1 HTTP/1.1 \n\n"

sendp(paquet)



