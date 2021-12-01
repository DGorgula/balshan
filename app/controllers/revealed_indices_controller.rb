class RevealedIndicesController < ApplicationController
  before_action :set_revealed_index, only: %i[ show edit update destroy ]

  # GET /revealed_indices or /revealed_indices.json
  def index
    @revealed_indices = RevealedIndex.all
  end

  # GET /revealed_indices/1 or /revealed_indices/1.json
  def show
  end

  # GET /revealed_indices/new
  def new
    @revealed_index = RevealedIndex.new
  end

  # GET /revealed_indices/1/edit
  def edit
  end

  # POST /revealed_indices or /revealed_indices.json
  def create
    @revealed_index = RevealedIndex.new(revealed_index_params)

    respond_to do |format|
      if @revealed_index.save
        format.html { redirect_to @revealed_index, notice: "Revealed index was successfully created." }
        format.json { render :show, status: :created, location: @revealed_index }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @revealed_index.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /revealed_indices/1 or /revealed_indices/1.json
  def update
    respond_to do |format|
      if @revealed_index.update(revealed_index_params)
        format.html { redirect_to @revealed_index, notice: "Revealed index was successfully updated." }
        format.json { render :show, status: :ok, location: @revealed_index }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @revealed_index.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /revealed_indices/1 or /revealed_indices/1.json
  def destroy
    @revealed_index.destroy
    respond_to do |format|
      format.html { redirect_to revealed_indices_url, notice: "Revealed index was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_revealed_index
      @revealed_index = RevealedIndex.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def revealed_index_params
      params.require(:revealed_index).permit(:game_id, :index)
    end
end
