require "open-uri"
class GamesController < ApplicationController
  before_action :set_game, only: %i[ show edit update destroy ]

  # GET /games or /games.json
  def index
    @games = Game.all
    # @games = Game.joins(word: {id: })
  end

  #
  def check_step
    word_length = params['word_length'].to_i-1
    @word_id = params['word_id'].to_i
    word = Word.find(@word_id)
    @word = word["ktiv_male"]

    @exist = []
    @on_spot = []
    for t in 0..word_length
      letter = params["letter"+t.to_s]
      if @word.include?(letter)
        if @word.index(letter) === t
          @on_spot.append({"index"=>t, "letter" => letter})
        else
          @exist.append({"index"=>t, "letter" => letter})
        end

      end
    end
    # @bla = params.receive_if{|letter| letter.match?(/^d$/)}
  end

  def game
    @bla = "dfgsdsfh"
  end
  def generate
    optionalWords = get_optional_words
    @chosenWord = optionalWords[rand(optionalWords.length)]
    @word = @chosenWord["ktiv_male"]
    @isWordSaved = Word.find_by(ktiv_male: @word)
    @keyword = @chosenWord["keyword"].split("_")[0]
    @definition = @chosenWord["hagdara"]
    @try = Word.new({:word => @keyword, :letterCount => @word.length, :sessionCount => 0, :ktiv_male => @word, :definition => @definition})
    @bla = "neutral"
    if @isWordSaved
      @bla = "True"
    else
      @try.save
      @id = @try.id
      @game = Game.new({:word => @try, :stepCount => 0})
      @game.save
      @bla = "False"
    end
    # if @try.save
    #   format.html { redirect_to @try, notice: "Word was successfully created." }
    #   format.json { render :show, status: :created, location: @try }
    # else
    #   format.html { render :new, status: :unprocessable_entity }
    #   format.json { render json: @try.errors, status: :unprocessable_entity }
    # end
  end
  # GET /games/1 or /games/1.json
  def show
  end

  # GET /games/new
  def new
    @game = Game.new
  end

  # GET /games/1/edit
  def edit
  end

  # POST /games or /games.json
  def create
    @game = Game.new(game_params)

    respond_to do |format|
      if @game.save
        format.html { redirect_to @game, notice: "Game was successfully created." }
        format.json { render :show, status: :created, location: @game }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @game.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /games/1 or /games/1.json
  def update
    respond_to do |format|
      if @game.update(game_params)
        format.html { redirect_to @game, notice: "Game was successfully updated." }
        format.json { render :show, status: :ok, location: @game }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @game.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /games/1 or /games/1.json
  def destroy
    @game.destroy
    respond_to do |format|
      format.html { redirect_to games_url, notice: "Game was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_game
      @game = Game.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def game_params
      params.require(:game).permit(:word_id, :stepCount)
    end

    # Http Request to Calanit to get optional words
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
      doc = JSON.parse(URI.open('https://kalanit.hebrew-academy.org.il/api/Ac?SearchString='+letter1+letter2).read)
      doc = clean(doc)
      if doc.length>0
        doc
      else
        get_optional_words
      end
    end
    def clean(arr)
      arr.delete_if { |obj|
        !obj["ktiv_male"] or obj["ktiv_male"].length<4 or obj["ktiv_male"].include?(" ") or obj["ktiv_male"].include?("-") or obj["ktiv_male"].include?("\"")
      }

    end
end
