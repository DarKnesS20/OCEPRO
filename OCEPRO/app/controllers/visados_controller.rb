class VisadosController < ApplicationController
  before_action :set_visado, only: [:show, :edit, :update, :destroy]
  before_filter :authenticate_usuario!

  # GET /visados
  # GET /visados.json
  def index
    @visados_params = parametros_filtro_visado
    @visados = Visado.all.filter(@visados_params)
    authorize @visados
    datos=@visados.select(:tipo).map(&:tipo)
    @moda = datos.mode
  end

  # GET /visados/1
  # GET /visados/1.json
  def show
  end

  # GET /visados/new
  def new
    @visado = Visado.new
  end

  # GET /visados/1/edit
  def edit
  end

  # POST /visados
  # POST /visados.json
  def create
    @visado = Visado.new(visado_params)
    @visado.created_by = @visado.updated_by = current_usuario
    respond_to do |format|
      if @visado.save && @visado.obra.may_procesar? && @visado.obra.procesar!
        format.html { redirect_to @visado, notice: 'Visado was successfully created.' }
        format.json { render :show, status: :created, location: @visado }
      else
        format.html { render :new }
        format.json { render json: @visado.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /visados/1
  # PATCH/PUT /visados/1.json
  def update
    respond_to do |format|
      if @visado.update(visado_params)
        format.html { redirect_to @visado, notice: 'Visado was successfully updated.' }
        format.json { render :show, status: :ok, location: @visado }
      else
        format.html { render :edit }
        format.json { render json: @visado.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /visados/1
  # DELETE /visados/1.json
  def destroy
    @visado.destroy
    @obra = @visado.obra
    respond_to do |format|
      format.html { redirect_to @obra, notice: 'Visado se eliminó satisfactoriamente.' }
      format.json { head :no_content }
    end
  end

  def honorarios_repeticion
   numero_de_repeticiones = params[:repeticiones]
   @porcentaje = Visado.honorarios_repeticion  
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_visado
      @visado = Visado.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def visado_params
      params.fetch(:visado).permit(
        :obra_id, :area_bruta,
        :tipo, :complejidad,
        :costo_construccion_estimado,
        :costo_estimado_proyecto,
        :costo_completo,
        :es_repeticion, 
        :cantidad_repeticiones,
        :costo_completo_repeticion,
        :arancel, :costo_construccion,
        :porcentaje_tabla_datos
        )
    end

    def parametros_filtro_visado
    params.permit(
      :nombres,
      :civ,
      :tipo,
      :desde,
      :hasta,
    )
  end
end
