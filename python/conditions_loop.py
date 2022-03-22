x = 5

if x < 9:
    print("Hello!")
elif x < 15:
    print("It's great to see you")
else:
    print("Bye!")

print("End")

# for loop
# for <loop_variable> in <iterable>:
#     <code>
# The iterable can be a list, tuple, dictionary, string, the sequence returned by range, a file, or any other type of iterable in Python.
# This is the general syntax to write a for loop with range():

# for <loop_variable> in range(<start>, <stop>, <step>):
#     <code>

for i in range(4, 0, -1):
    print(i)  # 4 to 1

for i in range(5):  # default starts with 0 and step as 1
    print(i)  # 0 to 4


my_list = (2, 3, 4, 5)
for num in my_list:
    if num % 2 == 0:
        print("Even")
    else:
        print("Odd")

my_dict = {"a": 1, "b": 2, "c": 3}

for i in my_dict:
    print(i)  # a b c in three lines

for value in my_dict.values():
    print(value)  # 1  2  3

my_list = [5, 6, 7, 8]

for i, elem in enumerate(my_list):
    print(i, elem)
# 0 5
# 1 6
# 2 7
# 3 8

# You can start the counter from a different number by passing a second argument to enumerate():

word = "Hello"

for i, char in enumerate(word, 2):
    print(i, char)

# 2 H
# 3 e
# 4 l
# 5 l
# 6 o

# The else Clause
# For loops also have an else clause. You can add this clause to the loop if you want to run a specific block of code when the loop completes all its iterations without finding the break statement.

my_list = [1, 2, 3, 4, 5]

for elem in my_list:
    if elem > 6:
        print("Found")
        break
else:
    print("Not Found")

# The output is:

# Not Found

# However, if the break statement runs, the else clause doesn't run. We can see this in the example below:

my_list = [1, 2, 3, 4, 5, 8]  # Now the list has the value 8

for elem in my_list:
    if elem > 6:
        print("Found")
        break
else:
    print("Not Found")

# The output is:

# Found

# The continue statement is used to skip the rest of the current iteration.
# The break statement is used to stop the loop immediately.s


def print_product(a, b=5):
    print(a * b)


print_product(4)  # 20

# parameters with default arguments have to be defined at the end of the list of parameters. Else, you will see this error: SyntaxError: non-default argument follows default argument.

#  Recursion in Python
def factorial(n):
    if n == 0 or n == 1:
        return 1
    else:
        return n * factorial(n - 1)


def fibonacci(n):
    if n == 0 or n == 1:
        return n
    else:
        return fibonacci(n - 1) + fibonacci(n - 2)


def find_power(a, b):
    if b == 0:
        return 1
    else:
        return a * find_power(a, b - 1)


# Python Documentation ; https://docs.python.org/3/tutorial/controlflow.html#

# for n in range(2, 10):
#     for x in range(2, n):
#         if n % x == 0:
#             print(n, "equals", x, "*", n // x)
#             break
#     else:
#         # loop fell through without finding a factor
#         print(n, "is a prime number")

# for num in range(2, 10):
#     if num % 2 == 0:
#         print("Found an even number", num)
#         continue
#     print("Found an odd number", num)

# Code that modifies a collection while iterating over that same collection can be tricky to get right. Instead, it is usually more straight-forward to loop over a copy of the collection or to create a new collection:

# # Strategy:  Iterate over a copy
# for user, status in users.copy().items():
#     if status == 'inactive':
#         del users[user]

# # Strategy:  Create a new collection
# active_users = {}
# for user, status in users.items():
#     if status == 'active':
# #         active_users[user] = status


# In many ways the object returned by range() behaves as if it is a list, but in fact it isn’t. It is an object which returns the successive items of the desired sequence when you iterate over it, but it doesn’t really make the list, thus saving space.

# We say such an object is iterable, that is, suitable as a target for functions and constructs that expect something from which they can obtain successive items until the supply is exhausted.

# pass Statements : The pass statement does nothing. It can be used when a statement is required syntactically but the program requires no action. For example:

# while True:
#     pass  # Busy-wait for keyboard interrupt (Ctrl+C)

# The default values in a function are evaluated at the point of function definition in the defining scope, so that

# i = 5
# def f(arg=i):
#     print(arg)
# i = 6
# f()
# # will print 5

# Important warning: The default value is evaluated only once. This makes a difference when the default is a mutable object such as a list, dictionary, or instances of most classes.

# def f(a, L=[]):
#     L.append(a)
#     return L
# print(f(1))
# print(f(2))
# print(f(3))

# # This will print
# # [1]
# # [1, 2]
# # [1, 2, 3]

# # If you don’t want the default to be shared between subsequent calls, you can write the function like this instead:
# def f(a, L=None):
#     if L is None:
#         L = []
#     L.append(a)
#     return L


# It is also possible to define functions with a variable number of arguments. There are three forms, which can be combined.
# 1. Default Argument Values
    # def ask_ok(prompt, retries=4, reminder='Please try again!'):
    #     while True:
    #         ok = input(prompt)
    #         if ok in ('y', 'ye', 'yes'):
    #             return True
    #         if ok in ('n', 'no', 'nop', 'nope'):
    #             return False
    #         retries = retries - 1
    #         if retries < 0:
    #             raise ValueError('invalid user response')
    #         print(reminder)

    # ask_ok('Do you really want to quit?')
    # ask_ok('OK to overwrite the file?', 2)
    # ask_ok('OK to overwrite the file?', 2, 'Come on, only yes or no!')

# 2. Keyword Arguments : Functions can also be called using keyword arguments of the form kwarg=value.
    # def parrot(voltage, state='a stiff', action='voom', type='Norwegian Blue'):
    #     print("-- This parrot wouldn't", action, end=' ')
    #     print("if you put", voltage, "volts through it.")
    #     print("-- Lovely plumage, the", type)
    #     print("-- It's", state, "!")

    # This function can be called in any of the following ways:
    # parrot(1000)                                          # 1 positional argument
    # parrot(voltage=1000)                                  # 1 keyword argument
    # parrot(voltage=1000000, action='VOOOOOM')             # 2 keyword arguments
    # parrot(action='VOOOOOM', voltage=1000000)             # 2 keyword arguments
    # parrot('a million', 'bereft of life', 'jump')         # 3 positional arguments
    # parrot('a thousand', state='pushing up the daisies')  # 1 positional, 1 keyword

    # but all the following calls would be invalid:
    # parrot()                     # required argument missing
    # parrot(voltage=5.0, 'dead')  # non-keyword argument after a keyword argument
    # parrot(110, voltage=220)     # duplicate value for the same argument
    # parrot(actor='John Cleese')  # unknown keyword argument

    # In a function call, keyword arguments must follow positional arguments. 
    # All the keyword arguments passed must match one of the arguments accepted by the function (e.g. actor is not a valid argument for the parrot function), and their order is not important. 
    # This also includes non-optional arguments (e.g. parrot(voltage=1000) is valid too). 
    # No argument may receive a value more than once. Here’s an example that fails due to this restriction: def function(a): pass >>> function(0, a=0)

    # When a final formal parameter of the form **name is present, it receives a dictionary (see Mapping Types — dict) containing all keyword arguments except for those corresponding to a formal parameter. This may be combined with a formal parameter of the form *name (described in the next subsection) which receives a tuple containing the positional arguments beyond the formal parameter list. (*name must occur before **name.) For example, if we define a function like this:

    # def cheeseshop(kind, *arguments, **keywords):
    #     print("-- Do you have any", kind, "?")
    #     print("-- I'm sorry, we're all out of", kind)
    #     for arg in arguments:
    #         print(arg)
    #     print("-" * 40)
    #     for kw in keywords:
    #         print(kw, ":", keywords[kw])

    # It could be called like this:

    # cheeseshop("Limburger", "It's very runny, sir.",
    #         "It's really very, VERY runny, sir.",
    #         shopkeeper="Michael Palin",
    #         client="John Cleese",
    #         sketch="Cheese Shop Sketch")

    # and of course it would print:

    # -- Do you have any Limburger ?
    # -- I'm sorry, we're all out of Limburger
    # It's very runny, sir.
    # It's really very, VERY runny, sir.
    # ----------------------------------------
    # shopkeeper : Michael Palin
    # client : John Cleese
    # sketch : Cheese Shop Sketch

# 3. Special parameters
    # By default, arguments may be passed to a Python function either by position or explicitly by keyword. For readability and performance, it makes sense to restrict the way arguments can be passed so that a developer need only look at the function definition to determine if items are passed by position, by position or keyword, or by keyword.

    # A function definition may look like:

    # def f(pos1, pos2, /, pos_or_kwd, *, kwd1, kwd2):
    #     -----------    ----------     ----------
    #         |             |                  |
    #         |        Positional or keyword   |
    #         |                                - Keyword only
    #         -- Positional only