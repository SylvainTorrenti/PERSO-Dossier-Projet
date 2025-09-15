#!/usr/bin/env python3
import sys
from hashlib import md5
from base64 import b64decode
from base64 import b64encode

from Crypto.Cipher import AES
from Crypto.Random import get_random_bytes
from Crypto.Util.Padding import pad, unpad

def encrypt(key, iv, fichier):
    f = open(fichier, "rb")
    data = f.read()
    f.close()
    
    cipher = AES.new(key, AES.MODE_CBC, iv)
    
    enc = b64encode(iv + cipher.encrypt(pad(data, AES.block_size)))
    
    f = open(fichier + ".enc", "wb")
    f.write(enc)
    f.close()
    return fichier + ".enc"
    

def decrypt(key, iv, fichier):
    f = open(fichier, "rb")
    data = f.read()
    f.close()
    
    raw = b64decode(data)
    cipher = AES.new(key, AES.MODE_CBC, raw[:AES.block_size])
    dec = unpad(cipher.decrypt(raw[AES.block_size:]), AES.block_size)
    
    f = open(fichier + ".dec", "wb")
    f.write(dec)
    f.close()

    return fichier + ".dec"



key = get_random_bytes(AES.block_size)
iv = get_random_bytes(AES.block_size)

fichier = sys.argv[1]

if fichier[-4:] == ".txt":
    encrypted = encrypt(key, iv, fichier)
    decrypted = decrypt(key, iv, encrypted)
    print(decrypted)

