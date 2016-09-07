# input and initial data
init_data = ["Illya", "0675170885", "illyababentsov@gmail.com"]
input_data = ["name=Vasya", "phone=0675555334", "email=vasya@mail.com"]

# class 1 for input 
class Input
	@array = []
	def initialize (array_input)
		@array = array_input
	end

	def check_array
		if @array.size == 3 && @array[0].start_with?("name=") && @array[1].start_with?("phone=") && @array[2].start_with?("email=")
			@array.each { |element|
				element.sub!("name=", "")
				element.sub!("phone=", "")
				element.sub!("email=", "")
			}
		else 
			puts "Error"
		end
	end
end

#class 2 for sustitution
class Substitution
	@block = ""
	@data_array = []
	def initialize (block_of_code, date_arr, init_arr)
		@block = block_of_code
		@data_array = date_arr
		@initial_data = init_arr
	end
	def check_block
		@block.sub!("#{@initial_data[0]}", "#{@data_array[0]}")
		@block.sub!("#{@initial_data[1]}", "#{@data_array[1]}")
		@block.sub!("#{@initial_data[2]}", "#{@data_array[2]}")
	end
end

# code
object_input = Input.new(input_data).check_array
IO.foreach("lesson4.html") do |block| 
	object_substitution = Substitution.new(block, object_input, init_data).check_block
end
newfile = File.new("lesson6.html", "w+")
newfile.syswrite("#{object_substitution}")
newfile.close



