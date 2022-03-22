# Common Exceptions in Python
    # ZeroDivisionError: raised when the second argument of a division or modulo operation is zero.
    # IndexError: raised when we try to use an invalid index to access an element of a sequence.
    # KeyError: raised when we try to access a key-value pair that doesn't exist because the key is not in the dictionary.
    # NameError: raised when we use a variable that has not been defined previously.
    # RecursionError: raised when the interpreter detects that the maximum recursion depth is exceeded. This usually occurs when the process never reaches the base case.

# try / except 
index = int(input("Enter the index: "))

try:
    my_list = [1, 2, 3, 4]
    print(my_list[index])
except:
    print("Please enter a valid index.")

# How to Catch a Specific Type of Exception in Python

index = int(input("Enter the index: "))

try:
    my_list = [1, 2, 3, 4]
    print(my_list[index])
except IndexError: # specify the type
    print("Please enter a valid index.")

# We can specify a name for the exception object by assigning it to a variable that we can use in the except clause. This will let us access its description and attributes.
index = int(input("Enter the index: "))

try:
    my_list = [1, 2, 3, 4]
    print(my_list[index])
except IndexError as e:
    print("Exception raised:", e)

# Enter the index: 15
# Exception raised: list index out of range

# We can add an else clause to this structure after except if we want to choose what happens when no exceptions occur during the execution of the try clause:

a = int(input("Enter a: "))
b = int(input("Enter b: "))

try:
    division = a / b
    print(division)
except ZeroDivisionError as err:
    print("Please enter valid values.", err)
else:
    print("Both values were valid.")

# If we enter the values 5 and 0 for a and b respectively, the output is: Please enter valid values. division by zero
# But if both values are valid, for example 5 and 4 for a and b respectively, the else clause runs after try is completed and we see: 1.25 \n Both values were valid.

# try / except / else / finally in Python : We can also add a finally clause if we need to run code that should always run, even if an exception is raised in try.

a = int(input("Enter a: "))
b = int(input("Enter b: "))

try:
    division = a / b
    print(division)
except ZeroDivisionError as err:
    print("Please enter valid values.", err)
else:
    print("Both values were valid.")
finally:
    print("Finally!")

# If both values are valid, the output is the result of the division and: Both values were valid. Finally!
# And if an exception is raised because b is 0, we see: Please enter valid values. division by zero Finally!

