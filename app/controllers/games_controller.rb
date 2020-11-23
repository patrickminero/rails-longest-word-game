require 'json'
require 'open-uri'

class GamesController < ApplicationController
  def new
    @letters = []
    10.times { @letters << ('a'..'z').to_a[rand(0..25)] }
    @letters
  end

  def score
    if condition
      @includes = "#{params[:word]} can be created out of #{params[:letters]}"
    else
      @includes = "#{params[:word]} cannot be created out of #{params[:letters]}"
    end
    
    if exist
      @valid = "#{params[:word]} exist in the english dictionary"
    else
      @valid = "#{params[:word]} is not an english word"
    end
  end

  def exist
    response = open("https://wagon-dictionary.herokuapp.com/#{params[:word]}")
    parsed_response = JSON.parse(response.read)
    parsed_response["found"]    
  end

  def condition
    params[:word].split('').all? { |letter| params[:letters].include? letter }
  end
end
