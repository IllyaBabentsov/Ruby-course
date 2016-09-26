require "yaml"
require 'mysql2'
require 'mimemagic'
require 'sqlite3'

class Database 

	def initialize base

		@client = Mysql2::Client.new(:host => "#{base["host"]}", :username => "#{base["username"]}", :password => "#{base["password"]}")
		@client.query("use `#{base["database"]}`") 

	end

	def show file_type

		@data = @client.query(@command)
		@data = @client.query(@command).each do |row|

			if MimeMagic.by_path("#{file_type}").child_of?(row["subtype"])
				puts "#{file_type}"
			end

		end

	end

	def select field = "*"
		@command = "SELECT #{field} FROM mime"
		self
	end

	def where key, value
		@command += " WHERE #{key}='#{value}'"
		self
	end

	def get
		@client.query(@command)
	end
end

class Database_sqlite

	def initialize 
		@client = SQLite3::Database.new 'sqlite_database.db'
	end

	def show 

		@data = @client.execute("SELECT * FROM mime") do |row|

		puts row

		end
	end
end



new_db = Database_sqlite.new.show
arr_dir = Dir.entries("Downloads")
Dir.chdir("Downloads")

for i in 0..(arr_dir.size - 1)

	if File.file?(arr_dir[i]) && MimeMagic.by_path(arr_dir[i]).image?

		new_db = Database_sqlite.new.show

	end
end
