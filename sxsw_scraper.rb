#!/usr/bin/env ruby

require 'json'
require 'nokogiri'
require 'open-uri'

require 'pp'

BASE_URL = "http://schedule.sxsw.com/?conference=music&lsort=name&day=ALL&event_type=Showcase"
alpha_list = %w(1 a b c d e f g h i j k l m n o p q r s t u v w x y z)

showcases = []
require 'rubygems'

alpha_list.each do |a|

  artists = []
  genres = []

  page = Nokogiri::HTML(open("#{BASE_URL}&a=#{a}"))
  page.encoding = 'utf-8'

  page.xpath("//div[contains(@class,'row eventcol')]").each do |row|

    # artist
    artist = row.xpath('div/div[1]/div/div/div/a')[0].content
    
    # genre
    genre = row.xpath('div/div[2]/div/div/div')[0].content.gsub('Showcase','').strip!

    # venue
    venue = row.xpath('div/div[2]/div/div[2]')[0].content.strip!

    # date
    date = row.xpath('div/div[2]/div/div[3]')[0].content.strip.gsub(/\s+/, " ")

    showcases << { artist: artist,
                   genre: genre,
                   venue: venue,
                   date: date
                 }
  end

end

puts JSON.pretty_generate(showcases)
#pp showcases
