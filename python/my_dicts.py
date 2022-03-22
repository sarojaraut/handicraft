d = {"x":1, "y":2}
print (d)
# add new key
d["z"]=3
print (d)

# delete a key
del d["z"]

print (d)

# Dictionary Methods

print(d.get("x"))
print(d.items())  # dict_items([('x', 1), ('y', 2)])
print(d.keys())   #dict_keys(['x', 'y'])
print(d.values()) #dict_values([1, 2])
print ("Loop Start")
print ("First")
for i in (d.items()):
  print (i)
# ('x', 1)
# ('y', 2)
print ("Second")
for i, j in (d.items()):
  print (i, j)
print ("Loop End")
# x 1
# y 2

x = d.popitem();
print (x) # ('y', 2)
print ("d="+str(d)) # d={'x': 1}

d.setdefault("y",2) #add new key with value as 2
print (d) # {'x': 1, 'y': 2}

d.setdefault("y",20) #no change as key is already there
print (d)  # {'x': 1, 'y': 2}

x = d.pop("x"); # if key does not exist then throws error KeyError: 'a'
print (x) #1

z= d.update({"x":10,  "z":30}) # z is none

z=d.clear()
print(z) #none
print(d) # {}