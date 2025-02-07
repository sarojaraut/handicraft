# 30 Days Of Python: Day 2 - Variables, Builtin Functions 30_Days_Of_Python_Day_2-Variables_Builtin_Functions.py

# Built in functions :In Python we have lots of built-in functions. Built-in functions are globally available for your use that mean you can make use of the built-in functions without importing or configuring. Some of the most commonly used Python built-in functions are the following: print(), len(), type(), int(), float(), str(), input(), list(), dict(), min(), max(), sum(), sorted(), open(), file(), help(), and dir().

# help('keywords') : Shows min(10,20,30)list of the Python keywords.

max(1,2,3,4,5) # 5
max([1,2,3,4,5]) # 5
min(1,2,3,4) # 1

# Variables
    # Python Variable Name Rules

    # A variable name must start with a letter or the underscore character
    # A variable name cannot start with a number
    # A variable name can only contain alpha-numeric characters and underscores (A-z, 0-9, and _ )
    # Variable names are case-sensitive (firstname, Firstname, FirstName and FIRSTNAME) are different variables)

print('Hello, World!') # The text Hello, World! is an argument
print('Hello',',', 'World','!') # it can take multiple arguments, four arguments have been passed
print(len('Hello, World!')) # it takes only one argument

# Multiple variables can also be declared in one line:
first_name, last_name, country, age, is_married = 'Asabeneh', 'Yetayeh', 'Helsink', 250, True
#all variables are declared and assigned values in order

print(first_name, last_name, country, age, is_married)
print('First name:', first_name)
print('Last name: ', last_name)
print('Country: ', country)
print('Age: ', age)
print('Married: ', is_married)

# Getting user input using the input() built-in function. Let us assign the data we get from a user into first_name and age variables. Example:

first_name = input('What is your name: ')
age = input('How old are you? ')

print(first_name)
print(age)

