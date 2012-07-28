require 'net/http'
require 'sinatra'
require 'json'

# This is my example from before class. 
# it's pretty much the same thing.

get '/' do
    erb :index
end

get '/hi' do
    "Hello World!"
end

get '/tweets' do
    tweet_json = get_tweets

    results = JSON.parse(tweet_json)

    tweets = results['results']

    #cleaned_tweets = []
    #tweets.each do |tweet|
    #    cleaned_tweets.push tweet['text']
    #end

    #cleaned_tweets
    erb :tweets, :locals => {
        :tweets => tweets,
        :name => "David"
    }
end

get '/raw_tweets' do
    content_type 'application/json'
    get_tweets
end

def get_tweets
    uri = URI.parse("http://search.twitter.com/search.json")
    params = { :q => 'kenya' }
    uri.query = URI.encode_www_form(params)

    response = Net::HTTP.get_response(uri)

    response.body
end
