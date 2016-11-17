class CostosController < ApplicationController
  helper_method :sort_column, :sort_direction
  before_action :set_costo, only: [:show, :edit, :update, :destroy]
  before_action :set_costo_por_descripcion, only: [:buscar_por_descripcion]
  before_filter :authenticate_usuario!

  # GET /costos
  # GET /costos.json
  def index
    @costos = Costo.all.order(sort_column+ ' ' + sort_direction)
    authorize @costos
  end

  # GET /costos/1
  # GET /costos/1.json

  def buscar_por_descripcion
    respond_to do |format|
      format.json { render json: @costo}
    end
  end

  # GET /costos/new
  def new
    @costo = Costo.new
    authorize @costo
  end

  # GET /costos/1/edit
  def edit
    authorize @costo
  end

  # POST /costos
  # POST /costos.json
  def create
    @costo = Costo.new(costo_params)
    authorize @costo

    @costo.created_by = current_usuario

    respond_to do |format|
      if @costo.save
        format.html { redirect_to costos_path, notice: 'Costo fue creado exitosamente.' }
      else
        format.html { render :new }

      end
    end
  end

  # PATCH/PUT /costos/1
  # PATCH/PUT /costos/1.json
  def update
    authorize @costo
    respond_to do |format|
      if @costo.update(costo_params)
        format.html { redirect_to costos_path, notice: 'Costo fue editado exitosamente.' }
      else
        format.html { render :edit }

      end
    end
  end

  # DELETE /costos/1
  # DELETE /costos/1.json

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_costo
      @costo = Costo.find(params[:id])
    end

    def set_costo_por_descripcion
      @costo = Costo.where(descripcion: params[:descripcion]).where('? between valido_desde and valido_hasta', Time.zone.now).last
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def costo_params
      params.fetch(:costo).permit(

      :descripcion,
      :costos,
      :valido_desde,
      :valido_hasta,
    )
    end
    def sort_column
      Costo.column_names.include?(params[:sort]) ? params[:sort] : "id"
    end
    
    def sort_direction
      %w[asc desc].include?(params[:direction]) ?  params[:direction] : "asc"
    end
end

