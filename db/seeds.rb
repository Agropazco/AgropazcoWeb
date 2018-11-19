# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

juanValdez = User.create!(name: "Juan Valdez",
             email: "jvaldez@mail.com",
             password:              "password",
             password_confirmation: "password",
             role: :vendor,
             activated: true,
             activated_at: Time.zone.now)

User.create!(name: "Comprador 1",
             email: "comprador1@mail.com",
             password:              "password",
             password_confirmation: "password",
             activated: true,
             role: :buyer,
             activated_at: Time.zone.now)

User.create!(name:  "Admin User",
             email: "admin@mail.com",
             password:              "password",
             password_confirmation: "password",
             role: :admin,
             activated: true,
             activated_at: Time.zone.now)

User.create!(name:  "Diego Said Niquefa Velasquez",
             email: "niquefa.diego@gmail.com",
             password:              "pniquefa",
             password_confirmation: "pniquefa",
             role: :buyer,
             activated: true,
             activated_at: Time.zone.now)


99.times do |n|
  name  = Faker::Name.name
  email = "example-#{n+1}@mail.com"
  password = "password"
  User.create!(name:  name,
               email: email,
               password:              password,
               password_confirmation: password,
               role: :buyer,
               activated: true,
               activated_at: Time.zone.now )
end

juanValdez.posts.create( title: "Apples", content: "Nice juicy apples, best price" )

users = User.order(:created_at).take(6)
50.times do 
  title = Faker::Lorem.sentence(1)
  content = Faker::Lorem.sentence(5)
  users.each{ |user| user.posts.create!(title: title , content: content)}
end

