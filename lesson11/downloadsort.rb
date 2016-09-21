require 'mimemagic'
require 'mysql2'

class Mysql_query

	@@database

	def get_database

		cliente = Mysql2::Client.new(:host => "localhost", :username => "root", :password => "sql")
		cliente.query("USE mime_db")
		@@database = cliente.query("SELECT * FROM mime WHERE type='image'")
	
	end

end

class Image_query < Mysql_query

	@image

	def initialize(image)
		@image = image
	end

	def image_type?

		@@database.each do |row|
			puts new_mime = MimeMagic.by_path(@image).child_of?(row["subtype"])
		end

	end

	def sort_image

		File.delete(@image)

	end

end



arr_dir = Dir.entries("Downloads")
Dir.chdir("Downloads")

new_db = Mysql_query.new.get_database

for i in 0..(arr_dir.size - 1)
	
	if File.file?(arr_dir[i]) && MimeMagic.by_path(arr_dir[i]).image?
		
		new_query = Image_query.new(arr_dir[i])
		new_query.sort_image if new_query.image_type?

	end
end
