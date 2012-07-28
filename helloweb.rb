require 'sinatra'
require 'net/http'
require 'json'

get '/' do
    "Hello World"
end

get '/example' do
end

#get '/hello/:name' do
#  # matches "GET /hello/foo" and "GET /hello/bar"
#  # params[:name] is 'foo' or 'bar'
#  "Hello #{params[:name]}!"
#end

post '/tweets' do

    puts "Params: " + params.to_s

    raw_tweets = get_tweets params[:search_term]
    
    everything = JSON.parse(raw_tweets)

    tweets = everything['results']

    
    erb :index, :locals => {
        :name => "David",
        :tweets => tweets
    }
end

get '/tweets/:search_term' do
    raw_tweets = get_tweets params[:search_term]
    
    everything = JSON.parse(raw_tweets)

    tweets = everything['results']

    
    erb :index, :locals => {
        :name => "David",
        :tweets => tweets
    }
end

def get_tweets(search_term)
    uri = URI.parse("http://search.twitter.com/search.json")
    params = { :q => search_term }
    uri.query = URI.encode_www_form(params)

    response = Net::HTTP.get_response(uri)

    response.body
end
