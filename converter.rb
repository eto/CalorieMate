#!/usr/bin/env ruby
# This is a converter for BrainFuck to CalorieMate. (C) 2020 Koichiro Eto
code = ARGF.read
commands1 = [">", "<", "+", "-", ".", ",", "[", "]"]
commands2 = ["C", "M", "a", "e", "o", "l", "r", "t"]
org = code.dup
commands1.each_with_index {|v, i|
  code.tr!(v, commands2[i])
}
puts "original", org
puts "converted", code
