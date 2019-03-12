# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

vendor1 = User.create!(name: "Juan Valdez",
             email: "jvaldez@mail.com",
             password:              "password",
             password_confirmation: "password",
             role: :vendor,
             activated: true,
             activated_at: Time.zone.now)

buyer1=User.create!(name: "Comprador 1",
             email: "comprador1@mail.com",
             password:              "password",
             password_confirmation: "password",
             activated: true,
             role: :buyer,
             activated_at: Time.zone.now)

admin1=User.create!(name:  "Admin User",
             email: "admin@mail.com",
             password:              "password",
             password_confirmation: "password",
             role: :admin,
             activated: true,
             activated_at: Time.zone.now)

chaves=User.create!(name: "Sebastian Chaves",
	           email: "jschavesr@gmail.com",
             password:              "pchaves",
             password_confirmation: "pchaves",
             role: :admin,
             activated: true,
             activated_at: Time.zone.now)


diego=User.create!(name:  "Diego Said Niquefa Velasquez",
             email: "niquefa.diego@gmail.com",
             password:              "pniquefa",
             password_confirmation: "pniquefa",
             role: :buyer,
             activated: true,
             activated_at: Time.zone.now)

6.times do |n|
  name  = Faker::Name.name
  email = "example-#{n+1}@mail.com"
  password = "password"
  User.create!(name:  name,
               email: email,
               password:              password,
               password_confirmation: password,
               role: :vendor,
               activated: true,
               activated_at: Time.zone.now )
end

99.times do |n|
  name  = Faker::Name.name
  email = "example-#{n+7}@mail.com"
  password = "password"
  User.create!(name:  name,
               email: email,
               password:              password,
               password_confirmation: password,
               role: :buyer,
               activated: true,
               activated_at: Time.zone.now )
end

vendor1Post1=vendor1.posts.create!( title: "Apples", content: "Nice juicy apples, best price" )

users = User.where(role:2).take(6)
50.times do 
  title = Faker::Lorem.sentence(1)
  content = Faker::Lorem.sentence(5)
  users.each{ |user| user.posts.create!(title: title , content: content)}
end

buyer1.post_reports.create!(post_id: vendor1Post1.id,topic: "prueba1",message: "Tiene imagenes bajadas de internet")
buyer1.post_reports.create!(post_id: vendor1Post1.id,topic: "prueba2",message: "Aunque ahora tiene imagenes diferentes estas siguen siendo falsas")
diego.post_reports.create!(post_id: vendor1Post1.id,topic: "prueba3",message: "Tiene una imagen que no tiene que ver con el producto")
