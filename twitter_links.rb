#-- by Wit Chitrapongse, https://github.com/wchitra

require 'open-uri'
require 'json'

ARGV.each do|a|
  @hashtag = a
end

@unique_links = Hash.new
#-- check for unique http links, add new link to hashmap, then check if the link
#-- is already there
def is_link_unique?( link )
	if( @unique_links[link].nil? )
		@unique_links[link] = link
		true
	else
		false
	end
end

TWITTER_SEACH_LINK = "http://search.twitter.com/search.json"
PARAMETERS = "?q=%%23%s&page%i"
OUTPUT = "%i. %s"

link_count = 1
twitter_result_page = 1

#-- remove the # sign if it came in thru the command line
#-- open-uri call to Twitter
@content = open( TWITTER_SEACH_LINK + PARAMETERS % [@hashtag.to_s.gsub("#", ""), twitter_result_page]).read
@tweets = JSON.parse(@content)

#-- make sure no errors
if @tweets["errors"].nil?

	#-- get 100 most recent links
	while link_count <= 100
		#-- if page thru the search results if cannot print 100 links
		if( twitter_result_page > 1)
			#-- use twitter's next page query parameters
			next_page = TWITTER_SEACH_LINK + @tweets['next_page']
			@content = open(next_page).read
			@tweets = JSON.parse( @content )
		end

		#-- parse thru the JSON results
		@tweets['results'].each do |tweet|
			tweet.each do |s|
				#-- only output the links, s[1] is the value at a particular key in the hash
				value = s[1]
				if value.to_s.start_with?('http:') && link_count <= 100
					if is_link_unique?(value)
						puts OUTPUT % [link_count, value]
						link_count += 1
					end
				end
			end
		 end

		#-- go the next page
		twitter_result_page += 1
	end
end