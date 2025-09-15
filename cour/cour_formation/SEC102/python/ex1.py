
import sys
import os

def concatene(a, b, c):
    return a + b + c

def affiche_1er_arg():
    if len(sys.argv) == 2:
        print(sys.argv[1])

def affiche_pwd():
    os.system("pwd")

s=concatene("1", "2", "3")

print(s)

affiche_1er_arg()

affiche_pwd()
