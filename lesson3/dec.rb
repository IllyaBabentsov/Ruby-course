# enter decimal, convert them to Integer
dec = gets.to_i

# variable for output information
dec_output = dec

# convert positive decimal into binary, otherwise ERROR.
if dec > 0 then
	dec_to_bin = ""
	loop do 
		dec_to_bin = "#{dec % 2}" + dec_to_bin
		dec = dec / 2
		break if dec == 1
	end
	puts "decimal digit  " + "#{dec_output} " "--> " + "1" + dec_to_bin
elsif dec < 0 then
	puts "#{dec} " + "is a negative number, please enter positive numder"
elsif dec == 0 then
	puts 'You might be type "0" or "letters", please enter tne number'
end

# convert binary into decimal

