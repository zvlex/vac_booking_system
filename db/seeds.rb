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
