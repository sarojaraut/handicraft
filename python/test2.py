header = ["A"*10, "B"*15, "C"*20]
headerLength = [len(i) for i in header]
data = [1,2,3]
print (headerLength)
for i, l in zip(data, headerLength):
    print(i,l)