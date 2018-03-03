#!/usr/bin/env ruby

require 'json'
require 'nokogiri'
require 'open-uri'
require 'pp'
require 'uri'

showcases = []

page = Nokogiri::HTML(open("https://schedule.sxsw.com/2018/events/type/showcase?days=all"))
page.encoding = 'utf-8'


page.xpath("//div[contains(@class,'row single-event presented-by-row')]").each do |row|

  showcase_url = row.attributes["data-event-url"].value
  artist = row.xpath('div/h4/a')[0].content
  datetime = row.xpath('div[2]/div')[0].content.gsub('2018', '2018 ')
  venue = row.xpath('div[3]/div')[0].children.first.content
  genre = row.xpath('div[4]/div')[0].children.first.content.strip

  showcases << {
    artist:       artist,
    datetime:     datetime,
    venue:        venue,
    genre:        genre,
    showcase_url: showcase_url
  }

end

puts JSON.pretty_generate(showcases)
