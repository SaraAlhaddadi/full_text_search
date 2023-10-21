# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
companies_data = []
100.times do
  companies_data << { name: Faker::Company.name, description: Faker::Company.catch_phrase, sector: Faker::Company.industry }
end

Company.insert_all(companies_data)

puts 'create 100 company --- done'

jobs_data = []
Company.ids.each do |company_id|
  100.times do
    jobs_data << { country: Faker::Address.country,title: Faker::Job.title, gender: Faker::Gender.binary_type,
                   skill: Faker::Job.key_skill, sector: Faker::Job.field, company_id: company_id,
                   salary: Faker::Number.between(from: 1000, to: 100000) }
  end
end

Job.insert_all(jobs_data)
puts 'create 100 * 100 jobs --- done'

