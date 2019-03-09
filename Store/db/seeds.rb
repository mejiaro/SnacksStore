# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
# movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
# Character.create(name: 'Luke', movie: movies.first)
require 'securerandom'
User.create(username: 'Carlos',
            email: 'cemg_neto@hotmail.com',
            password: '123456',
            password_confirmation: '123456')
User.create(username: 'Applaudo',
            email: 'client@applaudo.com',
            password: '123456',
            password_confirmation: '123456')
10.times do
  Category.create([{
                    name: Faker::Commerce.unique.department(1),
                    status: 'A'
                  }])
end
50.times do
  Product.create([{
                   sku: SecureRandom.uuid,
                   product_name: Faker::Commerce.unique.product_name,
                   price: Faker::Commerce.price,
                   quantity: rand(1..30),
                   category_id: rand(1..10),
                   status: 'A'
                 }])
end
