print(str(True + 1)) # 2
print("Saroj" + " " + "Raut") # Saroj Raut
print(("Saroj" + " " + "Raut")*3) # Saroj RautSaroj RautSaroj Raut
print("Hello" * 0) # ''
print("Hello" * -2) # ''

print( 6/2) # 3.0 returns a float as the result, If you try to divide by 0, you will get a ZeroDivisionError
print( 6//2) # 3 returns a int as the result, If you try to divide by 0, you will get a ZeroDivisionError
print( 6%5) # Modulo operator 1 returns a int as the result, If you try to divide by 0, you will get a ZeroDivisionError

# Comparison Operator Chaining
print( 10 < 20 < 30 ) # True

# Other operators
# Assignment Operators : =, +=, -=, *=, %=, /=, //=, **=
# Logical Operators : and, or, and not

# Membership Operators
print (5 in [1, 2, 3, 4, 5]) # True

message = "Hello, World!"

print("e" in message) # True

print("Hell" in message) # True