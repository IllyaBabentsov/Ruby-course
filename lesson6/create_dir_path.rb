arr_dir = IO.readlines("path_file.txt").delete_if do |line|
	line.to_s.chomp == nil || line.to_s.chomp == ""
end
Dir.mkdir("Lesson6")
Dir.chdir("Lesson6")
for i in 0..(arr_dir.size - 1)
	arr_line = arr_dir[i].to_s.split("/")
	for a in 0..(arr_line.size - 2)
		Dir.mkdir("#{arr_line[a]}")
		Dir.chdir("#{arr_line[a]}")
	end
	arr_dir[i].to_s.chomp.end_with?('/') ? nil : new_file = File.new("#{arr_line[arr_line.size - 1].to_s.chomp}", "w+")
	(arr_line.size - 1).times { Dir.chdir("..") }
end
