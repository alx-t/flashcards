#encoding: utf-8

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

Card.create(original_text: 'Car', translated_text: 'Автомобиль', review_date: Time.now)
Card.create(original_text: 'Cat', translated_text: 'Кот', review_date: Time.now)
Card.create(original_text: 'Dog', translated_text: 'Собака', review_date: Time.now)
Card.create(original_text: 'City', translated_text: 'Город', review_date: Time.now)