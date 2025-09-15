if __name__=="__main__":
    
    from Crypto.Cipher import AES
    from Crypto.Random import get_random_bytes
    
    with open("test.txt", "r") as fichier:
        contenu = fichier.read()  
        print(contenu)
        key = get_random_bytes(16)
        IV = get_random_bytes(16)
        cipher = AES.new(key, AES.MODE_CBC)
        ciphertext, tag = cipher.encrypt(contenu)
    