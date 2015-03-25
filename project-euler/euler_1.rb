#This program finds the sum of all the multiples of 3 or 5 below 1000.

numbers = []
sum = 0
x = 1
while x < 1000
    if x % 3 == 0
        numbers.push x
    elsif x % 5 == 0
        numbers.push x
    end
    x += 1
end

numbers.each { |i| sum += i }
    
print sum
