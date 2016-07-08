# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

person = Person.create(first_name: "Steve", last_name: "Jobs")
parking = Parking.create(kind: "street", hour_price: "2.50", day_price: "15.00", places: "100")

p "Created #{Person.count} people"
p "Created #{Parking.count} parkings"