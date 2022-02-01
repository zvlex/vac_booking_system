# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

user = User.find_or_initialize_by(full_name: 'Alexander Zutikov', email: 'azutikov@vaba.co')
user.assign_attributes(password: '123456789', password_confirmation: '123456789')
user.save

country = Country.find_or_create_by(name: 'Georgia', code: 'GE', active: true)
city = City.find_or_create_by(name: 'Tbilisi', code: '001', active: true, country_id: country.id)
district = District.find_or_create_by(name: 'Vake', code: '001', active: true, city_id: city.id)

BusinessUnit.find_or_create_by(
  name: 'TTH', code: 'TTH', active: true,
  country_id: country.id, city_id: city.id, district_id: district.id
)

puts 'Done'

country = Country.find_or_create_by(name: 'Ukraine', code: 'UA', active: true)
city = City.find_or_create_by(name: 'Kiev', code: '001', active: true, country_id: country.id)
district = District.find_or_create_by(name: 'Dis 1', code: '001', active: true, city_id: city.id)

city = City.find_or_create_by(name: 'Kiev', code: '001', active: true, country_id: country.id)
district = District.find_or_create_by(name: 'Dis 2', code: '002', active: true, city_id: city.id)

BusinessUnit.find_or_create_by(
  name: 'ABH', code: 'ABH', active: true,
  country_id: country.id, city_id: city.id, district_id: district.id
)

puts 'Done'
