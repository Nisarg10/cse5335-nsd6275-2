
require 'pg'
require 'json'
require 'open-uri'

data = JSON.parse(open("https://data.cityofnewyork.us/api/views/jb7j-dtam/rows.json?accessType=DOWNLOAD").read)

connection = PG.connect  :dbname => "dfm1q8av5dgnd5",
			  :user => "dckxytovmhkaqf",
                         :password => "TCiCqyCh-WqUb1FDNEmFACeM7h",
                         :host => "ec2-54-204-25-54.compute-1.amazonaws.com"

connection.exec "DROP TABLE IF EXISTS DeathCause"

connection.exec "CREATE TABLE DeathCause(id INTEGER PRIMARY KEY, Ethnicity TEXT, sex Text, CauseOfDeath TEXT, Year INTEGER)"

i = 1

while i < 101 
	Ethnicity = data[#{i}][8]
	sex = data[#{i}][9]
	CauseOfDeath = data[#{i}][10]
	Year = data[#{i}][7]
	connection.exec "INSERT INTO DeathCause VALUES('#{i}','#{Ethnicity}','#{sex}','#{CauseOfDeath}','#{Year}’)"
	i = i + 1
end

puts “Data Inserted.”