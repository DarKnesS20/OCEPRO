class HonorarioMinimosController < ApplicationController
  helper_method :sort_column, :sort_direction
  before_action :set_honorario_minimo, only: [:show, :edit, :update, :destroy]
  before_action :set_honorario_por_visado, only: [:buscar_por_costo_proyecto, :buscar_por_tipo_visado]
  before_filter :authenticate_usuario!

  # GET /honorario_minimos
  # GET /honorario_minimos.json
  def index
    @honorario_minimos = HonorarioMinimo.all.order(sort_column+ ' ' + sort_direction)
    authorize @honorario_minimos
  end

  # GET /honorario_minimos/1
  # GET /honorario_minimos/1.json
  def show
  end

  # GET /honorario_minimos/new
  def new
    @honorario_minimo = HonorarioMinimo.new
    authorize @honorario_minimo
  end

  # GET /honorario_minimos/1/edit
  def edit
  end

  # POST /honorario_minimos
  # POST /honorario_minimos.json
  def create
    @honorario_minimo = HonorarioMinimo.new(honorario_minimo_params)
    @honorario_minimo.created_by = current_usuario
    authorize @honorario_minimo
    respond_to do |format|
      if @honorario_minimo.save
        format.html { redirect_to honorario_minimos_path, notice: 'Honorario minimo fue creado con exito.' }

      else
        format.html { render :new }
      end
    end
  end

  # PATCH/PUT /honorario_minimos/1
  # PATCH/PUT /honorario_minimos/1.json
  def update
    authorize @honorario_minimo
    respond_to do |format|
      if @honorario_minimo.update(honorario_minimo_params)
        format.html { redirect_to honorario_minimos_path, notice: 'Honorario minimo fue editado con exito.' }
      else
        format.html { render :edit }
        format.json { render json: @honorario_minimo.errors, status: :unprocessable_entity }
      end
    end
  end



  def buscar_por_costo_proyecto
    @honorarios_minimos = @honorarios_minimos.
      where(concepto: params[:concepto]).costo(params[:costo])

    respond_to do |format|
      format.json { render json: @honorarios_minimos}
    end
  end

  def buscar_por_tipo_visado
    @honorarios_minimos = @honorarios_minimos.select(:concepto).distinct
    respond_to do |format|
      format.json { render json: @honorarios_minimos}
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_honorario_minimo
      @honorario_minimo = HonorarioMinimo.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def honorario_minimo_params
      params.require(:honorario_minimo).permit(:concepto, :desde, :hasta, :porcentaje, :tipo_visado)
    end

    def set_honorario_por_visado
      @honorarios_minimos = HonorarioMinimo.visado(params[:tipo_visado])
    end
    private
    def sort_column
      HonorarioMinimo.column_names.include?(params[:sort]) ? params[:sort] : "id"
    end
    
    def sort_direction
      %w[asc desc].include?(params[:direction]) ?  params[:direction] : "asc"
    end
    def sort_column
      HonorarioMinimo.column_names.include?(params[:sort]) ? params[:sort] : "id"
    end
    
    def sort_direction
      %w[asc desc].include?(params[:direction]) ?  params[:direction] : "asc"
    end
end
