class File_Validation

	@input_data = []
	@file_name = ""

	def initialize(input_data)
		
		@input_data = input_data

	end

	def  get_file
		
		@file_name

	end

	def valid?
		
		if @input_data.empty?
			
			puts "You didn't put any path"
		
		elsif @input_data.size > 1
			
			puts "You've put more than 1 parametr/path"
		
		elsif @input_data[0].to_s.end_with? '/'
			
			puts "Your path doesn't contain file at the end of root"
		
		elsif @input_data[0].to_s.start_with? '/'
			
			Dir.chdir '/'
			array_dir = @input_data[0].to_s.split '/'
			
			for i in 1..(array_dir.size - 2)
				
				Dir.exist?("#{array_dir[i]}") ? Dir.chdir("#{array_dir[i]}") : not_found_error(array_dir[i])
			
			end
			
			file_exist?("#{array_dir[array_dir.size - 1]}")
		
		else 
			
			puts "Incorrect root's form"
		
		end
	end

	def file_exist?(name_of_file)
		
		if File.file?(name_of_file) 
			
			@file_name = name_of_file
			return true
		
		else
			
			not_found_error(name_of_file, "File")

		end
	
	end

	private

	def not_found_error(element, file="Directory")
		
		puts "#{file} '#{element}' doesn't exist"

	end	

end

#--------------------------------------------------------------------------------------------------------------

class Shape_Inspector

	@incoming_str = []
	@@circle_hash = Hash.new
	@@rectangle_hash = Hash.new
	@@triangle_hash = Hash.new
	@@log_hash = Hash.new
	@@initial_dir = Dir.pwd

	def initialize(input_data=[])
		
		@incoming_str = input_data

	end

	def define_shape

		for i in 0..(@incoming_str.size - 1)
			
			exmp_var = @incoming_str[i].to_s

			if exmp_var.start_with?("Circle: ")
				
				def_param_of_shape(exmp_var.chomp.sub("Circle: ", ""), @@circle_hash, i + 1)

			elsif exmp_var.start_with?("Rectangle: ")
				
				def_param_of_shape(exmp_var.chomp.sub("Rectangle: ", ""), @@rectangle_hash, i + 1)
			
			elsif exmp_var.start_with?("Triangle: ")
				
				def_param_of_shape(exmp_var.chomp.sub("Triangle: ", ""), @@triangle_hash, i + 1)

			else 
				
				@@log_hash[:"#{i + 1}"] = @incoming_str[i].to_s.chomp
			
			end
		
		end

	end

	private

	def def_param_of_shape(str, shape, counter)
		
		arr_str = str.split(",")
		
		if arr_str == arr_str.select { |elem| is_int?("#{elem}") }
			
			shape[:"#{counter}"] = arr_str
		else

			@@log_hash[:"#{counter}"] = str

		end

	end

	def is_int?(item)

		convert = item.to_i
		
		if convert.to_s == item
			
			true
		else

			false

		end
	end	

end

#----------------------------------------------------------------------------------------------------------------
class Square < Shape_Inspector

	def put_circle_square

		puts "Circle:"
		
		@@circle_hash.each do |key, value| 
			
			if value.length == 1 then puts "#{3.14 * (value[0].to_i)**2} (#{key})" end
		
		end
	end

	def put_rectangle_square
		
		puts "Rectangle:"
		
		@@rectangle_hash.each do |key, value| 
			
			if value.length == 2 then puts "#{value[0].to_i * value[1].to_i} (#{key})" end

		end
	end

	def put_triangle_square
		
		puts "Triangle:"
		
		@@triangle_hash.each do |key, value| 
			
			if value.length == 2 
				
				puts "#{value[0].to_i * value[1].to_i * 0.5} (#{key})" 
			
			elsif value.length == 3
				
				puts "#{calc_tri_squre__by_3(value[0].to_i, value[1].to_i, value[2].to_i)} (#{key})"
			
			end
		end

	end

	private
	
	def calc_tri_squre__by_3(a, b, c)
		
		p = 0.5 * (a + b + c)
		return calc_square = (p * (p - a) * (p - b) * (p - c)) ** 0.5

	end

end

#----------------------------------------------------------------------------------------------------------------
class Log_Error < Shape_Inspector

	def record_log

		Dir.chdir(@@initial_dir)
		file_log = File.new("Errors.log", "w+")

		record(@@circle_hash, "Circle:", file_log, 1)
		record(@@rectangle_hash, "Rectangle:", file_log, 2)
		record_triangle(@@triangle_hash, "Triangle:", file_log)
		record(@@log_hash, "Another:", file_log, nil)

	end

	private

	def record(name_var, shape, file, j)
		
		file.syswrite("#{shape}\n")
		
		name_var.each do |key, value|
			
			if value.length != j then file.syswrite("#{key}\n") end
		
		end

	end

	def record_triangle(name_var, shape, file)
		
		file.syswrite("#{shape}\n")

		name_var.each do |key, value|
			
			if value.length != 2 && value.length != 3 then file.syswrite("#{key}\n") end
		
		end
	end

end

#----------------------------------------------------------------------------------------------------------------

data = ARGV
new_file = File_Validation.new(data)

if new_file.valid?

	array_line = IO.readlines("#{new_file.get_file}")
	new_shape = Shape_Inspector.new(array_line).define_shape

	circle = Square.new.put_circle_square
	rectangle  = Square.new.put_rectangle_square
	triangle = Square.new.put_triangle_square

	error_log = Log_Error.new.record_log

else 

	puts "Try again!"

end








