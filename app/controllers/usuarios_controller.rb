class UsuariosController < ApplicationController
  helper_method :sort_column, :sort_direction
  before_action :set_usuario, only: [:show, :edit, :update, :destroy, :validar_mail_v2, :validar_ci_v2,:validar_civ_v2]
  before_filter :authenticate_usuario!
  def index
    @usuarios_params = parametros_filtro_usuario
  	@usuarios = policy_scope(Usuario).where('deleted_at is null').filter(@usuarios_params)
    authorize @usuarios
  end
  def update
    respond_to do |format|
      if @usuario.update(usuario_params)
        format.html { redirect_to usuarios_path, notice: 'El usuario fue actualizado exitosamente.' }
        
      else
        format.html { render :edit }
        format.json { render json: @usuario.errors, status: :unprocessable_entity }
      end
    end
      
    authorize @usuario
  end
  
  def edit

  end

  def validar_usuario
    usuario = Usuario.select('usuario').where('usuario = ?',params[:usuario][:usuario])
    respond_to do |format|
      format.json { render json: !usuario.present?}
    end
  end

  def validar_mail
    usuario = Usuario.select('email').where('email = ?',params[:usuario][:email])
    respond_to do |format|
      format.json { render json: !usuario.present?}
    end
  end

  def validar_ci
    usuario = Usuario.select('usuario').where('cedula = ?',params[:usuario][:cedula])
    respond_to do |format|
      format.json { render json: !usuario.present?}
    end
  end

  def validar_civ
    usuario = Usuario.select('usuario').where('civ = ?',params[:usuario][:civ])
    respond_to do |format|
      format.json { render json: !usuario.present?}
    end
  end

  def validar_mail_v2
    usuario = Usuario.select('email').where('email = ?',params[:usuario][:email]).where('id != ?', @usuario.id)
    respond_to do |format|
      format.json { render json: !usuario.present?}
    end
  end

  def validar_ci_v2
    usuario = Usuario.select('usuario').where('cedula = ?',params[:usuario][:cedula]).where('id != ?', @usuario.id)
    respond_to do |format|
      format.json { render json: !usuario.present?}
    end
  end

  def validar_civ_v2
    usuario = Usuario.select('usuario').where('civ = ?',params[:usuario][:civ]).where('id != ?', @usuario.id)
    respond_to do |format|
      format.json { render json: !usuario.present?}
    end
  end

  def destroy  
    @usuario = Usuario.find(params[:id])
    @usuario.soft_delete

    respond_to do |format|
      if @usuario.save
        format.html { redirect_to usuarios_path, notice: 'La cuenta fue eliminada satisfactoriamente.' }
      else
        format.html { redirect_to usuarios_path, notice: 'No fue posible eliminar el usuario.' }
      end
    end
  end  


  def parametros_filtro_usuario
    params.permit(
      :usuario,
      :nombres,
      :cedula,
      :civ,
      :email,
      :role,
    ) 
  end 
   # Never trust parameters from the scary internet, only allow the white list through.
    def usuario_params
      params.fetch(:usuario).permit(

      :nombres,
      :apellidos,
      :cedula,
      :civ,
      :email,
      :role,
      :tipo_ci_coordinador,
    )
    end
  def set_usuario
    @usuario = Usuario.find(params[:id])
   end 
  private
  def sort_column
      Usuario.column_names.include?(params[:sort]) ? params[:sort] : "id"
  end
  
  def sort_direction
    %w[asc desc].include?(params[:direction]) ?  params[:direction] : "asc"
  end

end
