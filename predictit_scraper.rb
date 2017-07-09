#script for scraping from RealClearPolitics

#gems required for this to work
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
    #this searches for the specific tr class where the polling data is located
    if (tr['class'] == 'rcpAvg')
      #converts the scraped data to a string from a nokogiri element
      scraped_data_to_string = tr.to_s

      #TODO: The way we search for the data sucks. we need to write a better way
      #to retrieve this information.
      approval_rating_to_float << scraped_data_to_string[109..112].to_f
    end
  end

  #this checks if the data has changed.
  #TODO: Write a better way to check for the change in the polling data.
  #This requires a rewrite whenever a new poll is released. Requires automation.
  if approval_rating_to_float[1] != 39.9
    #TODO: Add code that would send our phone number a text message alert
    #I wonder if this could be done using WhatsApp, thus avoiding charges with Twilio.
    puts "the data has changed. Determine whether or not it would be prudent to execute a trade"
  end
end
