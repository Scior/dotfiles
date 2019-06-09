#!/usr/bin/env ruby

require 'json'
require 'net/http'
require 'uri'

API_URI = 'http://weather.livedoor.com/forecast/webservice/json/v1?city=130010'.freeze

parsed = URI.parse(API_URI)
http = Net::HTTP.new(parsed.hostname, parsed.port)
req = Net::HTTP::Get.new(parsed.request_uri)
res = http.request(req)

def make_temperature_label(str)
  return '' if str.nil?

  str['celsius'] + '℃'
end

JSON.parse(res.body)['forecasts'].each do |weather|
  date_label = weather['dateLabel']
  date = weather['date']
  telop = weather['telop']
  min_temp = make_temperature_label(weather['temperature']['min'])
  max_temp = make_temperature_label(weather['temperature']['max'])
  puts "#{date_label}(#{date}): #{telop} #{max_temp} #{min_temp}"
end
