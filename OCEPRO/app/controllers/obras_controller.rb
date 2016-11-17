class ObrasController < ApplicationController
  helper_method :sort_column, :sort_direction
  before_action :set_obra, only: [:show, :edit, :update, :oceprone, :destroy, :readpdf, :aprobar_obra, :visar, :rechazar, :pagar]
  before_filter :authenticate_usuario!
  RUTA_DIRECTORIO_ARCHIVOS = "public/archivos/"

  # GET /obras
  # GET /obras.json
  def index
    @status_obras = current_usuario.agremiado? ? TIPO_STATUS : TIPO_STATUS - ['creado']
    @obras_params = parametros_filtro_obra
    @obras = policy_scope(Obra).filter(@obras_params).order(sort_column+ ' ' + sort_direction) #tipo_obra(params[:tipo_obra]).uso_obra(params[:uso_obra])
    @usos = UsoConstruccion.all
    authorize @obras 
    @usuario = Usuario.all
    datos= @obras.select(:municipio_obra).map(&:municipio_obra)
    @moda = datos.mode
  end
  

  def aranceles
    @obras_params = parametros_filtro_obra_arancel
    @obras = policy_scope(Obra).filter(@obras_params).where('obras.status_obra = ?', :pagado) #tipo_obra(params[:tipo_obra]).uso_obra(params[:uso_obra])
    @obras = @obras.joins(:visados)
    @total = @obras.sum("visados.arancel")
    @obras = @obras.select("coordinador_proyecto_id, COUNT( distinct (CASE WHEN tipo_obra = 'ANTEPROYECTO' THEN obras.id END)) AS anteproyectos, COUNT(distinct(CASE WHEN tipo_obra = 'PROYECTO' THEN obras.id END)) AS proyectos, SUM(visados.arancel) AS arancel").group('coordinador_proyecto_id')
    authorize @obras 
  end

  def multifirma
     pdf_filename = Rails.root.join "public/parausuarios/multifirma.pdf"
     send_file(pdf_filename.to_s, :filename => "multifirma.pdf", :type => "application/pdf")
  end

  def manual
    send_file(Rails.root.join("public/parausuarios/manual.pdf"), 
      :disposition => "inline", :type => "application/pdf")
  end
  def pasantes
    send_file(Rails.root.join("public/parausuarios/operador.pdf"), 
      :disposition => "inline", :type => "application/pdf")
  end
  def irene
    send_file(Rails.root.join("public/parausuarios/admin.pdf"), 
      :disposition => "inline", :type => "application/pdf")
  end
  def junta
    send_file(Rails.root.join("public/parausuarios/master.pdf"), 
      :disposition => "inline", :type => "application/pdf")
  end
  def codigo
    send_file(Rails.root.join("public/parausuarios/codigo.pdf"), 
      :disposition => "inline", :type => "application/pdf")
  end  
  # GET /obras/1
  # GET /obras/1.json
  def show
    @indice_costos_uso_cats = IndiceCostosUsoCat.all
    @costos = Costo.all
    @cuota_civ = CostosCiv.last.civ
    respond_to do |format|
      format.html
      format.pdf do
        pdf = ObrasPdf.new(@obra, view_context)
        send_data pdf.render, filename: "#{@obra.tipo_obra}_#{@obra.id}.pdf", 
                              type: "application/pdf",
                              disposition: "inline"
      end
    end  

  end

  def readpdf
    send_file(Rails.root.join(@obra.memoria_descriptiva).to_s, 
      :disposition => "inline", :type => "application/pdf")
 end

  # GET /obras/new
  def new
    @obras = policy_scope(Obra).where(status_obra: :pagado).where(tipo_obra: 'ANTEPROYECTO')
    @obra = Obra.new
    authorize @obra
    @usos = UsoConstruccion.all
  end

  # GET /obras/1/edit
  def edit
    @obras = policy_scope(Obra).where(status_obra: :pagado).where(tipo_obra: 'ANTEPROYECTO')
    authorize @obra
    @usos = UsoConstruccion.all
  end

  # POST /obras
  # POST /obras.json
  def create
    @obra = Obra.new(obra_params)
    authorize @obra
    archivo = @obra.file
    nombre_orig = archivo.original_filename
    nombre  = "#{@obra.nombre}-#{Time.zone.now.strftime('%Y%m%d%H%M%S')}.pdf"
    directorio = RUTA_DIRECTORIO_ARCHIVOS
    extension = nombre_orig.slice(nombre_orig.rindex("."), nombre_orig.length).downcase
    if extension == ".pdf"
      path = File.join(directorio, nombre)
      resultado = File.open(path, "wb") { |f| f.write(archivo.read) }
      if resultado
        @obra.memoria_descriptiva = path
      end
    end

    @obra.coordinador_proyecto = current_usuario

    respond_to do |format|
      if @obra.save
        format.html { redirect_to @obra, notice: 'La Obra fue creada satisfactoriamente.' }
        format.json { render :show, status: :created, location: @obra }
      else
        format.html { render :new }
        format.json { render json: @obra.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /obras/1
  # PATCH/PUT /obras/1.json
  def update
    authorize @obra
    respond_to do |format|
      if @obra.update(obra_params)
        format.html { redirect_to @obra, notice: 'La obra fue modificata satisfactoriamente.' }
        format.json { render json: @obra, status: :ok, location: @obra }
      else
        format.html { render :edit }
        format.json { render json: @obra.errors, status: :unprocessable_entity }
      end
    end
  end
  
  def oceprone
    authorize @obra
    respond_to do |format|
      if @obra.update(obra_params)
        format.html { redirect_to @obra, notice: 'El numero de expediente ha sido asignado exitosamente.' }
        format.json { render json: @obra, status: :ok, location: @obra }
      else
        format.html { render :edit }
        format.json { render json: @obra.errors, status: :unprocessable_entity }
      end
    end
  end  
  # DELETE /obras/1
  # DELETE /obras/1.json
  def destroy
    @obra.destroy
    respond_to do |format|
      format.html { redirect_to obras_url, notice: 'La obra fue destruida satisfactoriamente.' }
      format.json { head :no_content }
    end
  end
  def estadisticas
    @obras = Obra.status_obra(:pagado)
    authorize @obras
    datos= @obras.select(:municipio_obra).map(&:municipio_obra)
    @moda = datos.mode
    @obras_mun= @obras.group(:municipio_obra).count
    @ingresos = Visado.joins(:obra).where('obras.status_obra = ?', :pagado).group_by_month('obras.created_at').sum(:arancel)
    @ingresos2 = Visado.joins(:obra).where('obras.status_obra = ?', :pagado).group_by_year('obras.created_at').sum(:arancel)
    
  end
  
  def estadistica_aplicada
    @obras_year= Visado.joins(:obra).where(created_at=""+@año_actual.to_s+"-1-1").group_by_month('obras.created_at').count.to_a.transpose[1]
    @modarep=Obra.status_obra(:pagado).select(:municipio_obra).map(&:municipio_obra)
    @media=@obras_year.mean
    @mediana=@obras_year.median
    @desviacion=@obras_year.standard_deviation
    @varianza=@obras_year.variance
    @moda=@modarep.mode
    
    respond_to do |format|
      format.html
      format.pdf do
        pdf = EstadisticaDescriptiva.new(Time.now.year,@obras_year,view_context,@media,@mediana,@desviacion,@varianza,@moda,current_usuario)
        send_data pdf.render, filename: "Reporte_estadistico "+Time.now.year.to_s+".pdf", type: 'application/pdf', disposition: "inline"
      end
    end
  end

  

  def aprobar_obra
    if @obra.may_aprobar_obra? && @obra.aprobar_obra!
      respond_to do |format|
        format.html { redirect_to @obra, notice: 'La obra fue enviada satisfactoriamente.' }
        format.json { head :no_content }
      end
    else
      respond_to do |format|
        format.html { redirect_to @obra, notice: 'La obra no pudo ser enviada.' }
        format.json { head :no_content }
      end
    end
  end

  def visar
    if @obra.may_visar? && @obra.visar!
      respond_to do |format|
        format.html { redirect_to @obra, notice: 'La obra fue procesada satisfactoriamente.' }
        format.json { head :no_content }
      end
    else
      respond_to do |format|
        format.html { redirect_to @obra, notice: 'La obra no pudo ser procesada.' }
        format.json { head :no_content }
      end
    end
  end

  def rechazar
    if @obra.may_rechazar? && @obra.rechazar!
      respond_to do |format|
        format.html { redirect_to @obra, notice: 'La obra fue rechazada.' }
        format.json { head :no_content }
      end
    else
      respond_to do |format|
        format.html { redirect_to @obra, notice: 'La obra no pudo ser rechazada. Intente nuevamente.' }
        format.json { head :no_content }
      end
    end
  end

  def pagar
    if @obra.may_pagar? && @obra.pagar!
      respond_to do |format|
        format.html { redirect_to @obra, notice: 'La obra fue pagada.' }
        format.json { head :no_content }
      end
    else
      respond_to do |format|
        format.html { redirect_to @obra, notice: 'La obra no pudo ser pagada. Intente nuevamente.' }
        format.json { head :no_content }
      end
    end
  end


  def validar_oceprone
    obra = Obra.select('n_oceprone').where('n_oceprone =?',params[:obra][:n_oceprone])
    respond_to do |format|
      format.json { render json: !obra.present?}
    end
  end 

  def regresion_lineal
    @obras = Obra.status_obra(:pagado)
    authorize @obras
    @a = 2016
    @b = Time.now.year
    Rails.logger.debug "Current usuario #{current_usuario.inspect}"
    respond_to do |format|
      format.html
      format.pdf do
        pdf = RegresionLineal.new(@obras, @a, @b, view_context, current_usuario)
        send_data pdf.render, filename: "regresion_lineal.pdf", type: 'application/pdf', disposition: "inline"
      end
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_obra
    @obra = policy_scope(Obra).find(params[:id])
  end

  def set_visados
    @obra = Obra.find(params[:id]).visados
  end

  def parametros_filtro_obra_arancel
    params.permit(
      :usuario_civ,
      :desde,
      :hasta,
    )
  end


  # Never trust parameters from the scary internet, only allow the white list through.
  def obra_params
    params.require(:obra).permit(
      :nombre,
      :propietario_parcela_nombre,
      :propietario_parcela_ci,
      :residente_obra_nombre,
      :residente_obra_civ,
      :direccion_obra,
      :municipio_obra,
      :uso_obra,
      :memoria_descriptiva,
      :n_oceprone,
      :area_parcela,
      :area_bruta_construccion,
      :area_neta_construccion,
      :tipo_obra,
      :file,
      :tipo_ci_juridico,
      :tipo_ci_residente,
      :residente_ci,
      :comentario,
      :rif,
      )
  end

  def parametros_filtro_obra
    p = params.permit(
      :tipo_obra,
      :uso_obra,
      :nombre,
      :usuario_civ,
      :municipio_obra,
      :desde,
      :hasta,
      :status_obra,
      :direccion_obra,
    )
    if !p[:status_obra].present? && !current_usuario.agremiado?
      p[:status_obra] = :pendiente
    end
    p
  end  
  private
    def sort_column
      Obra.column_names.include?(params[:sort]) ? params[:sort] : "obras.id"
    end
    
    def sort_direction
      %w[asc desc].include?(params[:direction]) ?  params[:direction] : "asc"
    end
end

