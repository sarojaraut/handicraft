# n = 9999999967
n = 10

for i in range(2, n):
    if n % i == 0:
        isPrime = False
        break
else:
    isPrime = True

if isPrime:
    print(n, "is prime")
else:
    print(n, "is not prime")
