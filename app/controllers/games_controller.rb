# frozen_string_literal: true

require 'open-uri'

class GamesController < ApplicationController # :nodoc:
  def new
    alphabet = ('A'..'Z').to_a
    big_alphabet = 4.times { alphabet }
    @letters = alphabet.sample(10)
  end

  def score
    @guess = params[:word]
    @letters = params[:letters]
    @word = find_word(@guess)
    @valid = in_grid_array(@letters, @guess)
    if @word && @valid
      @score = @guess.length
    else
      @score = 0
    end
  end

  def find_word(guess)
    url = "https://wagon-dictionary.herokuapp.com/#{params[:word]}"
    dictionary_serialized = JSON.parse(open(url).read)
    dictionary_serialized['found'] == true
  end

  def in_grid_array(grid, guess)
    grid_array = grid.downcase.split
    guess_array = guess.downcase.chars
    guess_array.all? { |letter| guess_array.count(letter) <= grid_array.count(letter) }
  end
end
