# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
User.create(email: Rails.application.secrets.username, password: Rails.application.secrets.password, password_confirmation: Rails.application.secrets.password)

from = Date.parse("1956-01-01")
to   = Date.parse("2013-01-01")


200.times do
  Patient.create(
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name,
    address1: Faker::Address.street_address,
    address2: Faker::Address.secondary_address,
    city: Faker::Address.city,
    phone1: Faker::Number.number(10).to_s,
    phone2: Faker::Number.number(10).to_s,
    date_of_birth: Faker::Date.between(from, to)
  )
end
