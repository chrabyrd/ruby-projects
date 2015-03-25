#This program finds the largest prime factor for a given number.

#I'm aware of the .Prime class in ruby, but I wanted to try solving this without it.

def largest_prime(n)
    array = []
    r = Range.new(2, n - 1)
    r.each { |x| array << x if n % x == 0 && (2...x).all? { |p| x % p != 0 }}
    puts array[-1]
end

print "Please enter a number: "
largest_prime(gets.chomp.to_i)
