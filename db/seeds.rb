# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
Customer.create!(
 email: 'taro@gmail.com',
 password: '123456',
 last_name: '山田',
 first_name: '太郎',
 customer_image: 'no_image.jpeg',
 last_name_kana: 'ヤマダ',
 first_name_kana: 'タロウ'
 )