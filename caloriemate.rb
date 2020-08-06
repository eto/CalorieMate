#!/usr/bin/env ruby
# CalorieMate interpreter (C) 2020 Koichiro Eto
# modified from bf.rb by Sebastian Kaspari (C) Sebastian Kaspari 2009
# Usage: ruby calotiemate.rb [FILE]
# Try: ruby caloriemate.rb examples/caloriemate.cm

msec = Time.now.to_f * 1000;
code = ARGF.read
le = code.length # input length
cl = 0 # cleaned length
cp = -1 # code pointer
p = 0 # cell pointer
c = [0] # cells
bm = {} # bracket map, jump directly to matching brackets! :)
bc = 0 # bracket counter
s = [] # bracket stack
ccp = 0 # code pointer for cleaned code

commands = ["C", "M", "a", "e", "o", "l", "r", "t"]

cleaned = []
until (cp+=1) == le
  case code[cp]
    when commands[6] then s.push(ccp) && bc += 1
    when commands[7] then (bm[s.pop] = ccp) && bc -= 1
  end
  bc < 0 && puts("Ending Bracket without opening, mismatch at #{cp}") && exit
  commands.include?(code[cp]) && (cleaned.push code[cp]) && ccp += 1
end

!s.empty? && puts("Opening Bracket without closing, mismatch at #{s.pop}") && exit

cp = -1
cl = cleaned.length
until (cp+=1) == cl
  case cleaned[cp]
    when commands[0] then (p += 1) && c[p].nil? && c[p] = 0
    when commands[1] then p <= 1 ? p = 0 : p -= 1
    when commands[2] then c[p] <= 254 ? c[p] += 1 : c[p] = 0
    when commands[3] then c[p] >= 1 ? c[p] -= 1 : c[p] = 255
    when commands[4] then print c[p].chr
    when commands[5] then c[p] = get_character.to_i
    when commands[6] then c[p] == 0 && cp = bm[cp]
    when commands[7] then c[p] != 0 && cp = bm.key(cp)
  end
end

runtime = Time.now.to_f * 1000 - msec
#puts "#{runtime} msecs [Used #{c.length} cells]"
