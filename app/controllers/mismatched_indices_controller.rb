class MismatchedIndicesController < ApplicationController
  before_action :set_mismatched_index, only: %i[ show edit update destroy ]

  # GET /mismatched_indices or /mismatched_indices.json
  def index
    @mismatched_indices = MismatchedIndex.all
  end

  # GET /mismatched_indices/1 or /mismatched_indices/1.json
  def show
  end

  # GET /mismatched_indices/new
  def new
    @mismatched_index = MismatchedIndex.new
  end

  # GET /mismatched_indices/1/edit
  def edit
  end

  # POST /mismatched_indices or /mismatched_indices.json
  def create
    @mismatched_index = MismatchedIndex.new(mismatched_index_params)

    respond_to do |format|
      if @mismatched_index.save
        format.html { redirect_to @mismatched_index, notice: "Mismatched index was successfully created." }
        format.json { render :show, status: :created, location: @mismatched_index }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @mismatched_index.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /mismatched_indices/1 or /mismatched_indices/1.json
  def update
    respond_to do |format|
      if @mismatched_index.update(mismatched_index_params)
        format.html { redirect_to @mismatched_index, notice: "Mismatched index was successfully updated." }
        format.json { render :show, status: :ok, location: @mismatched_index }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @mismatched_index.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /mismatched_indices/1 or /mismatched_indices/1.json
  def destroy
    @mismatched_index.destroy
    respond_to do |format|
      format.html { redirect_to mismatched_indices_url, notice: "Mismatched index was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_mismatched_index
      @mismatched_index = MismatchedIndex.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def mismatched_index_params
      params.require(:mismatched_index).permit(:game_id, :step_id, :index)
    end
end
