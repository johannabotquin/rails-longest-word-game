require 'json'
require 'open-uri'

class GamesController < ApplicationController
  def new
    @letters = 10.times.map { ('A'..'Z').to_a.sample }
  end

  def score
    url = "https://dictionary.lewagon.com/#{params[:word]}"
    user_serialized = URI.open(url).read
    @word = JSON.parse(user_serialized)
    @score = 0
    word_found
    corresponding_letters
    @score += params[:word].length if word_found && corresponding_letters
  end

  private

  def word_found
    @word['found']
  end

  def corresponding_letters
    array_of_word_letter = params[:word].upcase.split('')
    array_of_word_letter.all? do |letter|
      array_of_word_letter.count(letter) <= params[:letters].count(letter)
    end
  end
end
