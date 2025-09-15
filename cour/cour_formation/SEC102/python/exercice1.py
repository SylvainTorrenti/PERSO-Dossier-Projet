if __name__=="__main__":

    import sys
    import os

    def concatenation(a, b, c):
        return a + '' + b + '' + c
    
    print(concatenation('aa','bb','cc'))

    print(sys.argv[0])
    
    print(os.getcwd())
        
        