require 'json'
require 'open-uri'

class GamesController < ApplicationController
  def new
    @letters = Array('A'...'Z').sample(10)
  end

  def score
    @word = params[:word]
    @grid = params[:grid]
    @good_word = good_grid?(@word,@grid)
    @response = @good_word ? english_word(@word) : 0
  end

  private

  def good_grid?(word, grid)
    letters = word.downcase.split("")
    grid = grid.downcase.split(" ")
    letters.each do |letter|
      if grid.include? letter
        grid.delete(letter)
      else
        return false
      end
    end
    return true
  end

def english_word(word)
  url = open("https://wagon-dictionary.herokuapp.com/#{word}").read
  response = JSON.parse(url)
  if response['found']
    return response['length']
  else
    return false
  end
end
end
