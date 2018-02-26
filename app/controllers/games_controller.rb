require 'open-uri'

class GamesController < ApplicationController
  def new
    @letters = ("A".."Z").to_a.sample(10)
    session[:score] ||= 0
  end

  def score
    @grid = params[:grid].chars
    @answer = params[:user_answer].upcase.chars
    on_grid = @answer.all? { |char| @grid.count(char) == @answer.count(char) }
    doc =  JSON.parse(open("https://wagon-dictionary.herokuapp.com/#{params[:user_answer]}").read)
    english_word = doc["found"]
    if  on_grid && english_word
      length = doc["length"].to_i
      session[:score] += length
      @message = "<strong>Congratulations</strong> #{@answer.join.upcase} is a valid English word your score #{session[:score]}"
    elsif english_word == false
      @message = "Sorry buy <strong>#{@answer.join.upcase}</strong> does not seem to be a valid English word..."
    else
      @message = "Sorry buy <strong>#{@answer.join.upcase}</strong> can't be built out of #{@grid.join(',')}"
    end
  end
end
