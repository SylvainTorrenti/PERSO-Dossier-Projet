if __name__=="__main__":
    
    import requests
    
    i = 1
    while i < 6:
        x = str(i)
        url = "http://172.31.200.63:8000/index.php?id="+''+x
        res = requests.get(url)
        print(res.content)
        i = i + 1