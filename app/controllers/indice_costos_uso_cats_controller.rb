class IndiceCostosUsoCatsController < ApplicationController
  helper_method :sort_column, :sort_direction
  before_action :set_indice_costos_uso_cat, only: [:show, :edit, :update, :destroy]
  before_filter :authenticate_usuario!
  # GET /indice_costos_uso_cats
  # GET /indice_costos_uso_cats.json
  def index
    @indice_costos_uso_cats = IndiceCostosUsoCat.all.order(sort_column+ ' ' + sort_direction)
    authorize @indice_costos_uso_cats
  end

  # GET /indice_costos_uso_cats/1
  # GET /indice_costos_uso_cats/1.json
  def show
  end

  # GET /indice_costos_uso_cats/new
  def new
    @indice_costos_uso_cat = IndiceCostosUsoCat.new
    authorize @indice_costos_uso_cat
  end

  # GET /indice_costos_uso_cats/1/edit
  def edit
  end

  # POST /indice_costos_uso_cats
  # POST /indice_costos_uso_cats.json
  def create
    @indice_costos_uso_cat = IndiceCostosUsoCat.new(indice_costos_uso_cat_params)
    authorize @indice_costos_uso_cat

    respond_to do |format|
      if @indice_costos_uso_cat.save
        format.html { redirect_to indice_costos_uso_cats_path, notice: 'Indice costos por uso y categoría ha sido agregado' }    
      else
        format.html { render :new }
      end
    end
  end

  # PATCH/PUT /indice_costos_uso_cats/1
  # PATCH/PUT /indice_costos_uso_cats/1.json
  def update
    authorize @indice_costos_uso_cat
    respond_to do |format|
      if @indice_costos_uso_cat.update(indice_costos_uso_cat_params)
        format.html { redirect_to indice_costos_uso_cats_path, notice: 'Indice costos por uso y categoría fue actualizado.' }
        
      else
        format.html { render :edit }
        format.json { render json: @indice_costos_uso_cat.errors, status: :unprocessable_entity }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_indice_costos_uso_cat
      @indice_costos_uso_cat = IndiceCostosUsoCat.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def indice_costos_uso_cat_params
      params.require(:indice_costos_uso_cat).permit(
      :vivienda_uso,
      :indice_complejidad,   
      :indice_costo,
      )
    end
    def sort_column
      IndiceCostosUsoCat.column_names.include?(params[:sort]) ? params[:sort] : "id"
    end
    
    def sort_direction
      %w[asc desc].include?(params[:direction]) ?  params[:direction] : "asc"
    end
end
