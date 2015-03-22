#encoding: utf-8

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

=begin
Card.create(original_text: 'Car', translated_text: 'Автомобиль', review_date: Time.now)
Card.create(original_text: 'Cat', translated_text: 'Кот', review_date: Time.now)
Card.create(original_text: 'Dog', translated_text: 'Собака', review_date: Time.now)
Card.create(original_text: 'City', translated_text: 'Город', review_date: Time.now)
=end

require 'open-uri'
require 'nokogiri'

url = "http://www.languagedaily.com/learn-german/vocabulary/common-german-words"

doc = Nokogiri::HTML(open(url))
items = doc.xpath("//td")
index = 5
step = 4
while (index < items.length) do
  original_text = items[index].text
  translated_text = items[index+1].text
  Card.create(original_text: original_text, translated_text: translated_text)
  index += step
end
