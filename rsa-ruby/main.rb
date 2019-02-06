require 'byebug'
require 'progress_bar'
require 'ruby-prof'
require 'benchmark'
require './lib/rsa.rb'
require 'prime'

n = 211582871

p = n.prime_division[0][0]
q = n.prime_division[1][0]

phi = (p - 1) * (q - 1)

c = 127

d = RSA.inverse_modulaire(c, phi)

puts RSA.integer_to_string RSA.dechiffrement(RSA.string_to_integer("LHRZNS"), n, d)
