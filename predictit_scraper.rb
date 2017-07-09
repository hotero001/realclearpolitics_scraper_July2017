#script for scraping from predictit

require 'nokogiri'
require 'httparty'
require 'open-uri'
require 'twilio-ruby'

while true do
  url = 'https://www.realclearpolitics.com/epolls/other/president_trump_job_approval-6179.html'
  doc = Nokogiri::HTML(open(url))

  tr = doc.css('tr')

  approval_rating_to_float = []

  tr.each do |tr|
    if (tr['class'] == 'rcpAvg')
  	  #converts the scraped data to a string from a nokogiri element
  	  #a = tr.to_s
  	  #puts tr
      scraped_data_to_string = tr.to_s
  	  approval_rating_to_float << scraped_data_to_string[109..112].to_f
      #puts tr.at_css("td")
    end
  end

  #here is where we would send a text message to our phone letting us know
  #that the data has been updated, thus prompting us to execute a trade, hopefully
  if approval_rating_to_float[1] != 39.9
    puts "the data has changed. Determine whether or not it would be prudent to execute a trade"
  end
end
