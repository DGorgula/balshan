require "open-uri"
class GamesController < ApplicationController
  before_action :set_game, only: %i[ show edit update destroy ]

  # GET /games or /games.json
  def index
    @games = Game.all
  end

  #
  def check_step
    word_length = params['word_length'].to_i-1
    @word_id = params['word_id'].to_i
    @game = Game.find(params['game_id'].to_i)
    word = Word.find(@word_id)
    @word = word["ktiv_male"]
    @stepWord = params["stepWord"]
    step = Step.new(game: @game, stepWord: @stepWord)
    step.save
    @exist = []
    @in_place = []
    @stepWord.each_char.with_index do |letter, stepWordIndex|
      checkedLetters = ""
      if checkedLetters.include?(letter)
        puts "the letter is already exist:", letter
        next
      end
      puts "after letter check:", letter
      letterIndices = (0..@word.length).find_all do |i|
        @word[i]===letter
      end
      letterIndices.each do |wordIndex|
        if checkedLetters.include?(letter)
          puts "the letter is already exist:", letter
          next
        end
        if stepWordIndex === wordIndex
          @in_place.append(Hash[wordIndex, letter])
          newIndex = RevealedIndex.new(game_id: @game.id.to_i, step_id: step.id.to_i, index: stepWordIndex)
          newIndex.save
        else
          @exist.append(Hash[stepWordIndex, letter])
          newIndex = MismatchedIndex.new(game_id: @game.id.to_i, step_id: step.id.to_i, index: stepWordIndex)
          newIndex.save
        end
      end
    end
    @gameSteps = Step.where(game: @game)
    @game.increment(:stepCount, 1)
    @game.save
    @revealed_indices = RevealedIndex.where(game_id: @game.id.to_i)
    @mismatched_indices = MismatchedIndex.where(game_id: @game.id.to_i)
    @updated_word, @is_game_over = get_display_word(@word, @revealed_indices.map do |obj| obj.index.to_i end)
    if @is_game_over
      @dict_word, @definition = word["word"], word["definition"]
    end
  end

  def game
    @bla = "dfgsdsfh"
  end
  def generate
    optionalWords = get_optional_words
    @chosenWord = optionalWords[rand(optionalWords.length)]
    @word = @chosenWord["ktiv_male"]
    @savedWord = Word.find_by(ktiv_male: @word)
    @keyword = @chosenWord["keyword"].split("_")[0]
    @definition = @chosenWord["hagdara"]
    if @savedWord
      # puts "========================word exist!"
      @savedWord.increment(:sessionCount, 1)
      @savedWord.save
    else
    @savedWord = Word.new(word: @keyword, letterCount: @word.length, sessionCount: 1, ktiv_male: @word, definition: @definition)
      @savedWord.save
      @word_id = @savedWord.id
      @game = Game.new(word: @savedWord, stepCount: 0)
      @game.save
      # puts "=======================word doesnt exist, created new one."
    end
    # if @savedWord.save
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
      letters = Array.new(27) do |e|
        e = "%D7%"+(144 + e).to_s(16)
      end
      endingLetters.each do |arr|
          letters.delete(arr)
      end


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
        !obj["ktiv_male"] or obj["ktiv_male"].length<4 or obj["ktiv_male"].include?(" ") or obj["ktiv_male"].include?("־") or obj["ktiv_male"].include?("\"")
      }
    end

    def get_display_word(word, revealed_indices)
      updated_word = ""
      is_full_word_revealed = true
      puts revealed_indices
      word.each_char.with_index do |c, i|
        if revealed_indices.include?(i)
          # puts "DFGXHGVKJHN;LKNLMNKYGFKYHFGGFV"
          updated_word = updated_word+c+" "
        else
          if is_full_word_revealed === true
            is_full_word_revealed = false
          end
          updated_word = updated_word+"_ "
        end
      end
      return updated_word, is_full_word_revealed
    end
end
