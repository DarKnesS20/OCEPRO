class CostosCivsController < ApplicationController
  before_action :set_costos_civ, only: [:show, :edit, :update, :destroy]
  before_filter :authenticate_usuario!
  # GET /costos_civs
  # GET /costos_civs.json
  def index
    @costos_civs = CostosCiv.all
    authorize @costos_civs
  end



  # GET /costos_civs/new
  def new
    @costos_civ = CostosCiv.new
    authorize @costos_civ
  end

  # GET /costos_civs/1/edit
  def edit
    authorize @costos_civ
  end

  # POST /costos_civs
  # POST /costos_civs.json
  def create
    @costos_civ = CostosCiv.new(costos_civ_params)
    @costos_civ.created_by = current_usuario
    authorize @costos_civ

    respond_to do |format|
      if @costos_civ.save
        format.html { redirect_to costos_civs_path, notice: 'Unidad C.I.V fue creada satisfactoriamente.' }
      else
        format.html { render :new }
      end
    end
  end

  # PATCH/PUT /costos_civs/1
  # PATCH/PUT /costos_civs/1.json
  def update
    authorize @costos_civ
    respond_to do |format|
      if @costos_civ.update(costos_civ_params)
        format.html { redirect_to costos_civs_path, notice: 'Unidad CIV fue modificada satisfactoriamente.' }

      else
        format.html { render :edit }
       
      end
    end
  end


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_costos_civ
      @costos_civ = CostosCiv.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def costos_civ_params
      params.fetch(:costos_civ).permit(:civ)
    end
end
