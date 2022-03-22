# x = [ [1, 2, 3, 4], [5, 6, 7, 8], [9, 10, 11, 12]]

# for i in range(len(x)):
#     for j in range(len(x[i])):
#         print(x[i][j])

# transposed = []

# for i in range(4):
#     transposed_row = []
#     for row in x:
#         transposed_row.append(row[i])
#     transposed.append(transposed_row)

# print (transposed)

# [[row[i] for row in x] for i in range(4)]

x = [1,2,3]

x= [x**2 for x in x ]

print (x)