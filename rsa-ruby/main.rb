require 'byebug'
require 'progress_bar'
require 'ruby-prof'
require 'benchmark'
require './lib/rsa.rb'
require 'prime'

puts RSA.decode "LHRZNS", 211582871, 127
puts RSA.decode "AYMRNCI", 844991843, 349837
puts RSA.decode "IVWTRM.FPL", 202899206548601, 39898535
exit