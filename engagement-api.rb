require 'oauth'
require 'zlib'

base_url = 'https://data-api.twitter.com'
consumer_key = ''
consumer_secret = ''
access_token = ''
access_token_secret = ''

#Assemble your array of Tweet IDs.
tweet_ids = ['740963277056802818','738199724340051968','748388801588920321']

#Assemble your array of Engagement Types.
engagement_types = ['impressions','engagements','favorites']

#Assemble your list of up to 10 Groupings.
groupings =  '{"my_grouping_by_id_and_type": {"group_by": ["tweet.id",	"engagement.type"]}'

#Assemble request from the above Tweet ID list, Engagement Types, and Groupings.
request = "{\"tweet_ids\": #{tweet_ids},\"engagement_types\": #{engagement_types}, \"groupings\":#{groupings}}}"

#Reference access tokens and create an API OAuth object to make POST requests with.
consumer = OAuth::Consumer.new(consumer_key, consumer_secret, {:site => base_url})
token = {:oauth_token => access_token, :oauth_token_secret => access_token_secret}
api = OAuth::AccessToken.from_hash(consumer, token)

#Engagement API includes three endpoints. If your package does not include one of these, comment that call out.

#Make call to /totals endpoint
uri_path = '/insights/engagement/totals'
result = api.post(uri_path, request, {"content-type" => "application/json", "Accept-Encoding" => "gzip"})
result.body =  Zlib::GzipReader.new( StringIO.new( result.body ) ).read
puts result.body

#Make call to /28hr endpoint
uri_path = '/insights/engagement/28hr'
result = api.post(uri_path, request, {"content-type" => "application/json", "Accept-Encoding" => "gzip"})
result.body =  Zlib::GzipReader.new( StringIO.new( result.body ) ).read
puts result.body

#Make call to /historical endpoint
uri_path = '/insights/engagement/historical'
result = api.post(uri_path, request, {"content-type" => "application/json", "Accept-Encoding" => "gzip"})
result.body =  Zlib::GzipReader.new( StringIO.new( result.body ) ).read
puts result.body

