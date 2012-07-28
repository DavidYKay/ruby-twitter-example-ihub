require 'sinatra'
require 'net/http'
require 'json'

get '/' do
    "Hello World"
end

get '/example' do
end

get '/tweets' do
    raw_tweets = get_tweets 
    
    everything = JSON.parse(raw_tweets)

    tweets = everything['results']
    result_string = "<ul>"

    tweets.each do |tweet|
        result_string += "<li>"
        result_string += tweet['text']
        result_string += "</li>"
    end
    result_string += "</ul>"

    #erb :index, :locals => {
    #    :name => "David",
    #    :tweets => tweets
    #}

    result_string
end

def get_tweets 
   # |search_term|
    uri = URI.parse("http://search.twitter.com/search.json")
    params = { :q => "olympics" }
    uri.query = URI.encode_www_form(params)

    response = Net::HTTP.get_response(uri)

    response.body
end
