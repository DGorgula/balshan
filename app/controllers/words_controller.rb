require 'nokogiri'
require 'open-uri'
require 'stringex'

class WordsController < ApplicationController
  before_action :set_word, only: %i[ show edit update destroy ]

  # GET /words or /words.json
  def index
    @words = Word.all
  end

  # GET /words/1 or /words/1.json
  def show
  end

  # GET /words/new
  def new
    @word = Word.new
  end

  # GET /words/1/edit
  def edit
  end

  # POST /words or /words.json
  def generate_word

    @word = get_optional_words
  end


  # POST /words or /words.json
  def create
    @word = Word.new(word_params)

    respond_to do |format|
      if @word.save
        format.html { redirect_to @word, notice: "Word was successfully created." }
        format.json { render :show, status: :created, location: @word }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @word.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /words/1 or /words/1.json
  def update
    respond_to do |format|
      if @word.update(word_params)
        format.html { redirect_to @word, notice: "Word was successfully updated." }
        format.json { render :show, status: :ok, location: @word }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @word.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /words/1 or /words/1.json
  def destroy
    @word.destroy
    respond_to do |format|
      format.html { redirect_to words_url, notice: "Word was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_word
      @word = Word.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def word_params
      params.require(:word).permit(:word, :letterCount, :sessionCount)
    end

    # Get Request to Calanit to get optional words
    def get_optional_words
      endingLetters = ["%D7%9a", "%D7%9d", "%D7%9f", "%D7%a3", "%D7%a5"]
      letters = Array.new(27) { |e|
        e = "%D7%"+(144 + e).to_s(16)
      }
      endingLetters.each { |arr|
          letters.delete(arr)
      }


      letter1 = letters[rand(letters.length)]
      letter2 = letters[rand(letters.length)]
      # Fetch and parse HTML document
      # url = stringex.acts_as_url 'https://kalanit.hebrew-academy.org.il/api/Ac?SearchString='
      doc = JSON.parse(URI.open('https://kalanit.hebrew-academy.org.il/api/Ac?SearchString='+letter1+letter2).read)
      doc
    end
end
