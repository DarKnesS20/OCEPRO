class AreaExterioresController < ApplicationController
  helper_method :sort_column, :sort_direction 
  before_filter :authenticate_usuario!
  before_action :set_tipos_area_por_tamano, only: [:buscar_por_tipo_area]
  def index
    @area_exteriores = AreaExteriore.all.order(sort_column+ ' ' + sort_direction)
    authorize @area_exteriores
  end

  def new
    @area_exteriore = AreaExteriore.new
    authorize @area_exteriore
  end

  def buscar_por_tipo_area
    respond_to do |format|
      format.json { render json: @area_exteriores}
    end
  end
  def edit
    @area_exteriore = AreaExteriore.find(params[:id])
    authorize @area_exteriore

  end

  def create
    @area_exteriore = AreaExteriore.new(area_exteriore_params)

    #FIXME
    @area_exteriore.created_by = current_usuario
    authorize @area_exteriore

    respond_to do |format|
      if @area_exteriore.save
        format.html { redirect_to area_exteriores_path, notice: 'Área exterior creada con éxito.' }
      else
        format.html { render :new }
      end
    end
  end
  def update
    @area_exteriore = AreaExteriore.find(params[:id])
    authorize @area_exteriore
    respond_to do |format|
      if @area_exteriore.update(area_exteriore_params)
        format.html { redirect_to area_exteriores_path, notice: 'Área exterior editada exitosamente.' }

      else
        format.html { render :edit }
       
      end
    end
  end

 
  private
    # Use callbacks to share common setup or constraints between actions.
    def area_exteriore
      @area_exteriore = AreaExteriore.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def area_exteriore_params
      params.require(:area_exteriore).permit(
        :tipo_area,
        :concepto,
        :desde,
        :hasta,
        :porcentaje_concepto,
        )
    end

    def set_tipos_area_por_tamano
      @area_exteriores = AreaExteriore.tipo_area(params[:tipo_area]).tamano(params[:tamano])
    end
    def sort_column
      AreaExteriore.column_names.include?(params[:sort]) ? params[:sort] : "id"
    end
    
    def sort_direction
      %w[asc desc].include?(params[:direction]) ?  params[:direction] : "asc"
    end
end

