data = ARGV
if data.size == 3 && data[0].start_with?("name=") && data[1].start_with?("phone=") && data[2].start_with?("email=")
	newfile = File.new("lesson6.html", "w+")
	array_str = IO.readlines("lesson4.html")
	array_str.each do |item|
		item.sub!("#{item.slice(item.index("Page"), item.size)}", "Page about #{data[0].sub("name=", "")}") if item.include?("Page about")
		item.sub!("#{item.slice(item.index("Telephone"), item.size)}", "Telephone</strong> - #{data[1].sub("phone=", "")}</p>") if item.include?("Telephone")
		item.sub!("#{item.slice(item.index("Email</strong>"), item.size)}", "Email</strong> - #{data[2].sub("email=", "")}</p>") if item.include?("Email</strong>")
		newfile.syswrite("#{item}")
	end
else
	puts 'Error. Correct format is "name=Name phone=0971111111 email=mymail@mail.com"'
end

