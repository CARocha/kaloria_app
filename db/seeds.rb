# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

User.create!(
    email: "carlos@example.com",
    password: "12345678"
)

49.times do
    User.create!(
        email: Faker::Internet.email,
        password: "12345678"
     )
end

(4.months.ago.to_date..Date.current).each do |fecha|
    User.all.each do |usuario|
        Calory.create!(
            user_id: usuario.id,
            calories_ingested: Faker::Number.between(from: 100.0, to: 1000.0),
            calories_burned: Faker::Number.between(from: 100.0, to: 1000.0),
            comment: Faker::Lorem.sentence(word_count: 13),
            date: fecha
        )
    end
end