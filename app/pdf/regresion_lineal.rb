class RegresionLineal < Prawn::Document
	def initialize(obras, ano_inicial, ano_final, view, usuario)
		super(top_margin: 70)
		Rails.logger.debug("Inicializando regresion lineal")
		Rails.logger.debug "Usuario #{usuario.inspect}"
		#Variables declaradas en el controlador que se pasan por parámetro al crear el objeto Regresion lineal
		@obras = obras
		@view = view
		@usuario = usuario
		@ano_inicial = ano_inicial
		@ano_final = ano_final
		todo_junto_test
		table_data
		number_pages "<page>/<total>", {:start_count_at => 1,
                                        :at => [0, 0],
                                        :align => :center,
                                        :size => 14}
	end

	def todo_junto_test
		filename = "#{Rails.root}/app/assets/images/ocepro.png"
		image filename, at: [235, 750], width: 95
		text " #{ltz(Time.now)}", :align => :right
		move_down 15
		text "J-40418583-6", :align =>:center, :size=>9, :color=>"#00004d", :style=>:bold
		move_down 20
		text " CENTRO DE INGENIEROS DEL ESTADO NUEVA ESPARTA ", :align => :center, :size => 12
		text " C.I.E.N.E", :align => :center
		text " OFICINA COORDINADORA DEL EJERCICIO PROFESIONAL", :align => :center
		text " O.C.E.P.R.O", :align => :center


		move_down 30
		text " REPORTE REGRESIÓN LINEAL SIMPLE", :align => :center, :size => 16
		move_down 20
		# llamar a función que procesa los datos que se imprimiran en la tabla
		data = table_data
		# creación de tabla
		table(data, :width => 540 ,  :cell_style => {:padding => [0, 0, 0, 10]}) 
		move_down 30
		text " EMITIDO POR: #{@usuario.nombres.upcase} #{@usuario.apellidos.upcase}", :align => :center
	end


	#  función que procesa datos y devuelve un arreglo con los datos que deben mostrarse en la tabla
	def table_data
		#Inicializacion de la variable data, donde se en cuentran los datos que se mostrarán en la tabla
		# Estaticamente solo se inicializa el encabezado y el año 2015
		data = [
				[{content: "AÑO", colspan: 3, :align=> :center}, 
					{content: "VISADOS REALIZADOS", colspan: 6, :align=> :center},
					{content: "DIFERENCIA PORCENTUAL", colspan: 4, :align=> :center}],
	 			[{content: "2015", colspan: 3, :align=> :center}, 
	 				{content: "SIN REGISTROS", colspan: 6, :align=> :center},
	 				{content: "SIN REGISTROS", colspan: 4, :align=> :center}]]

	 	#iteración desde el año inicial hasta el final para calculo de regresión
	 	for a in @ano_inicial..@ano_final
		
			total_obras_ano = @obras.select(:municipio_obra).where(:created_at=>''+a.to_s+'-1-1'..''+(a.to_i+1).to_s+'-1-1').count
			total_obras_ano_ant = @obras.select(:municipio_obra).where(:created_at=>''+(a.to_i-1).to_s+'-1-1'..''+a.to_s+'-1-1').count
			regresion_lineal = (total_obras_ano.to_f - total_obras_ano_ant.to_f)/ total_obras_ano.to_f
			#creación de la fila que se imprimirá en la tabla correspondiente al año de la iteración (a)
			row = [{content: "#{a}", colspan: 3, :align=> :center}, 
					{content: "#{total_obras_ano}", colspan: 6, :align=> :center},
					{content: "#{number_porcentaje(regresion_lineal.to_f*100)} %", colspan: 4, :align=> :center}]
			# agregar fila al final de data
			data.push row
		end
		#retornar data
		data

	end
	




	def number_numero(numerito)
		@view.number_to_currency(numerito, unit: " ", delimiter: ".", precision: 0)
	end

	def number_porcentaje(numero)
		@view.number_to_currency(numero, unit: " ", delimiter: ".", separator: ",", precision: 2)
	end
	def ltz(timestamp, options = {})
	    return nil if timestamp.blank?
	    timestamp.strftime("%d/%m/%Y")
	end
end

