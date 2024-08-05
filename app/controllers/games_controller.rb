require 'open-uri'
require 'json'
DICT = 'https://dictionary.lewagon.com/'

class GamesController < ApplicationController
  def new
    # TODO: generate random grid of letters
    charset = ('A'..'Z').to_a
    @letters = (0...10).to_a.map { charset.sample }
  end

  def valid_word?(word)
    JSON.parse(URI.open("#{DICT}#{word}").read)["found"]
  end

  def word_in_grid?(word, grid)
    word.upcase.chars.each do |char|
      if grid.include?(char)
        grid.delete_at(grid.index(char))
      else
        return false
      end
    end
    true
  end

  def run_game(attempt, grid, start_time, end_time)
    # TODO: runs the game and return detailed hash of result (with `:score`, `:message` and `:time` keys)
    result = {}
    grid = grid.split(' ')
    grid_init = grid.clone
    if word_in_grid?(attempt, grid)
      if valid_word?(attempt)
        result[:message] = "CONGRATULATIONS! #{attempt.upcase} is a valid English word!"
        result[:score] = attempt.length
      else
        result[:message] = "Sorry but #{attempt.upcase} does not seem to be an English word"
        result[:score] = 0
      end
    else
      result[:message] = "Sorry but #{attempt.upcase} cannot be built out of #{grid_init.join(', ')}"
      result[:score] = 0
    end
    result
  end

  def score
    letters = params['letters']
    @result = run_game(params['guess'], letters, 1, 1)
  end
end
