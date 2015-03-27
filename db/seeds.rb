#encoding: utf-8

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

=begin
require 'open-uri'
require 'nokogiri'

url = "http://www.languagedaily.com/learn-german/vocabulary/common-german-words"

doc = Nokogiri::HTML(open(url))
#doc = Nokogiri::HTML(open(url, 
      :proxy_http_basic_authentication => 
      ["http://proxy:3128", "teal", "pjjgfhr0"]))
items = doc.xpath("//td")
index = 5
step = 4
while (index < items.length) do
  original_text = items[index].text
  translated_text = items[index+1].text
  Card.create(original_text: original_text, translated_text: translated_text)
  index += step
end
=end
