#This program finds the sum of the even-value terms in the Fibonacci sequence for values up to four million.

even_fib = []
r = 0

def fib (n)
    return n if n <= 1
    fib(n - 1) + fib(n - 2)
end

while fib(r) < 4000000
    if fib(r) % 2 == 0
        even_fib << fib(r)
    end
    r += 1
end 

sum = 0

even_fib.each { |x| sum += x }

print sum
