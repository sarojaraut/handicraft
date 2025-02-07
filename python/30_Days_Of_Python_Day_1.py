# Assignments can be done on more than one variable "simultaneously" on the same line like this
a, b = 3, 4
print(a, b)


# change this code
mystring = 'hello'
myfloat = 10.0
myint = 20

# testing code
if mystring == "hello":
    print("String: %s" % mystring)
if isinstance(myfloat, float) and myfloat == 10.0:
    print("Float: %f" % myfloat)
if isinstance(myint, int) and myint == 20:
    print("Integer: %d" % myint)


# Lists are very similar to arrays. They can contain any type of variable, and they can contain as many variables as you wish.
numbers = []
strings = []
names = ["John", "Eric", "Jessica"]

# write your code here
numbers.append(1)
numbers.append(2)
numbers.append(3)
strings.append('hello')
strings.append('world')
second_name = names[1]

del(numbers) #delete a variable

# this code should write out the filled arrays and the second name in the names list (Eric).
print(numbers)
print(strings)
print("The second name on the names list is %s" % second_name)

# Basic Operators
x = object()
y = object()

# TODO: change this code
x_list = [x] * 10
y_list = [y] * 10
big_list = x_list + y_list

print("x_list contains %d objects" % len(x_list))
print("y_list contains %d objects" % len(y_list))
print("big_list contains %d objects" % len(big_list))

# testing code
if x_list.count(x) == 10 and y_list.count(y) == 10:
    print("Almost there...")
if big_list.count(x) == 10 and big_list.count(y) == 10:
    print("Great!")

# String Formatting
data = ("John", "Doe", 53.44)
format_string = "Hello %s %s. Your current balance is $%s."

print(format_string % data) #To use two or more argument specifiers, use a tuple (parentheses)

# Data types
# Integer: Integer(negative, zero and positive) numbers Example: ... -3, -2, -1, 0, 1, 2, 3 ...
# Float: Decimal number Example ... -3.5, -2.25, -1.0, 0.0, 1.1, 2.2, 3.5 ...
# Complex Example 1 + j, 2 + 4j
# String : A collection of one or more characters under a single or double quote. If a string is more than one sentence then we use a triple quote.

# Boolean : A boolean data type is either a True or False value. T and F should be always uppercase.

# List : Python list is an ordered collection which allows to store different data type items. A list is similar to an array in JavaScript.
[0, 1, 2, 3, 4, 5]  # all are the same data types - a list of numbers
['Banana', 'Orange', 'Mango', 'Avocado'] # all the same data types - a list of strings (fruits)
['Finland','Estonia', 'Sweden','Norway'] # all the same data types - a list of strings (countries)
['Banana', 10, False, 9.81] # different data types in the list - string, integer, boolean and float

# Dictionary : A Python dictionary object is an unordered collection of data in a key value pair format.

{
'first_name':'Asabeneh',
'last_name':'Yetayeh',
'country':'Finland',
'age':250,
'is_married':True,
'skills':['JS', 'React', 'Node', 'Python']
}

# Tuple : A tuple is an ordered collection of different data types like list but tuples can not be modified once they are created. They are immutable.

('Earth', 'Jupiter', 'Neptune', 'Mars', 'Venus', 'Saturn', 'Uranus', 'Mercury') # planets

# Set : A set is a collection of data types similar to list and tuple. Unlike list and tuple, set is not an ordered collection of items. Like in Mathematics, set in Python stores only unique items.

{2, 4, 3, 5}
{3.14, 9.81, 2.7} # order is not important in set

# Checking Data types : To check the data type of certain data/variable we use the type function.

type(3.0) # <class 'float'>
