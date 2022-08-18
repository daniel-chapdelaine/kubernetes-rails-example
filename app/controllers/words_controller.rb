class WordsController < ApplicationController
  self.per_form_csrf_tokens = true


  def index
    @word = Word.new
    @words = Word.all.pluck(:text)
  end

  def new
    @word = Word.new(params.permit(:text))
    @word.save
    redirect_to "/"
  end
  
end
