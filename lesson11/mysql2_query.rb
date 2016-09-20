require 'mysql2'

client = Mysql2::Client.new(:host => "localhost", :username => "root", :password => "sql")

client.query("USE shape_db")

figure_name = client.query("SELECT * FROM figures")
#         {"figure_name"=>"Circle"}
#         {"figure_name"=>"Reactangle"}
#         {"figure_name"=>"Triangle"}

figure_formula = client.query("SELECT * FROM formulas")
#         {"figure"=>"Circle", "formula"=>"3,14*r*r"}
#         {"figure"=>"Triangle", "formula"=>"0,5*a*h"}
#         {"figure"=>"Triangle", "formula"=>"(p*(p-a)*(p-b)*(p-c))**0,5"}
#         {"figure"=>"Triangle", "formula"=>"r*p"}
#         {"figure"=>"Reactangle", "formula"=>"a*b"}

figure_name.each do |name|
	puts name["figure_name"]
	figure_formula.each do |form|
		if name["figure_name"] == form["figure"]
			puts form["formula"]
		end
	end
#   Circle
#   3,14*r*r
#   Reactangle
#   a*b
#   Triangle
#   0,5*a*h
#   (p*(p-a)*(p-b)*(p-c))**0,5
#   r*p

end









