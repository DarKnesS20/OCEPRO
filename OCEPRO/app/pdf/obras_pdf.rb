class ObrasPdf < Prawn::Document
	def initialize(obra, view)
		super(top_margin: 70)
		@obra = obra 
		@view = view
		#obra_id
		todo_junto_test
	end
	def obra_id
		text "obra \##{@obra.id}", size:14
		#visados
	end

	def todo_junto_test
		filename = "#{Rails.root}/app/assets/images/ocepro.png"
		image filename, at: [235, 750], width: 95
		move_down 30
		text " CENTRO DE INGENIEROS DEL ESTADO NUEVA ESPARTA ", :align => :center, :size => 12
		text " C.I.E.N.E ", :align => :center
		text " OFICINA COORDINADORA DEL EJERCICIO PROFESIONAL ", :align => :center
		text " O.C.E.P.R.O ", :align => :center

		move_down 10
		text_box "Construcción destinada a USO:", :at=> [0,cursor], :width => 200
		bounding_box([200, cursor], :width => 340) do
			text "#{@obra.uso_obra}", :align => :center
			stroke_horizontal_rule
		end

		move_down 10
		text_box "Propietario:", :at=> [0,cursor], :width => 70
		bounding_box([70, cursor], :width => 250) do
			text "#{@obra.propietario_parcela_nombre.upcase}", :align => :center
			stroke_horizontal_rule
		end
		move_up 10 #al usar el text_box debo subir la linea si trabajare con doble informacion en una linea
		text_box "CI / RIF:", :at=> [370,cursor], :width => 45
		bounding_box([420, cursor], :width => 120) do
			move_up 1
			if @obra.tipo_ci_juridico.strip == "J.-" || @obra.tipo_ci_juridico.strip == "G.-"
			text "#{@obra.tipo_ci_juridico}#{@obra.propietario_parcela_ci} #{@obra.rif}", :align => :center
			else
			text "#{(@obra.tipo_ci_juridico)}#{number_numero(@obra.propietario_parcela_ci)}#{@obra.rif}", :align => :center
			end	
			stroke_horizontal_rule
		end
		move_down 10
		text_box "Coodinador del proyecto:", :at=> [0,cursor], :width => 270
		bounding_box([200, cursor], :width => 340) do
			text "#{@obra.coordinador_proyecto.nombres.capitalize} #{@obra.coordinador_proyecto.apellidos.capitalize}", :align => :center
			stroke_horizontal_rule
		end
		move_down 15
		text_box "C.I.V", :at=> [0,cursor], :width => 70
		bounding_box([70, cursor], :width => 250) do
			move_up 3
			text "#{number_numero(@obra.coordinador_proyecto.civ)}", :align => :center
			stroke_horizontal_rule
		end
		move_up 13
		text_box "C.I:", :at=> [370,cursor], :width => 50
		bounding_box([420, cursor], :width => 120) do
			move_down 3
			text "#{(@obra.coordinador_proyecto.tipo_ci_coordinador)}#{number_numero(@obra.coordinador_proyecto.cedula)}", :align => :center
			stroke_horizontal_rule
		end
		move_down 15
		text_box "Prof. Residente de la Obra:", :at=> [0,cursor], :width => 200
		bounding_box([200, cursor], :width => 340) do
			text "#{@obra.residente_obra_nombre.upcase}", :align => :center
			stroke_horizontal_rule
		end
		move_down 18
		text_box "C.I.V", :at=> [0,cursor], :width => 70
		bounding_box([70, cursor], :width => 250) do
			move_up 6
			text "#{number_numero(@obra.residente_obra_civ)}", :align => :center
			stroke_horizontal_rule
		end
		move_up 12
		text_box "C.I:", :at=> [370,cursor], :width => 50
		bounding_box([420, cursor], :width => 120) do
			move_up 3
			text "#{(@obra.tipo_ci_residente)}#{number_numero(@obra.residente_ci)}", :align => :center
			stroke_horizontal_rule
		end
		move_down 15
		text_box "Fecha", :at=> [0,cursor], :width => 70
		bounding_box([70, cursor], :width => 250) do
			text "#{ltz(@obra.created_at)}", :align => :center
			stroke_horizontal_rule
		end
		move_up 12
		text_box "O.C.P.Nº", :at=> [370,cursor], :width => 50
		bounding_box([420, cursor], :width => 120) do
		move_down 2
		if @obra.tipo_obra.strip == "ANTEPROYECTO"
			text "#{number_numero(@obra.n_oceprone)} ANT", :align => :center, :size => 12, :style => :bold
		else @obra.tipo_obra.strip == "PROYECTO"
			text "#{number_numero(@obra.n_oceprone)} PROY", :align => :center, :size => 12, :style => :bold
		end
		stroke_horizontal_rule
		end
		move_down 15
		text "Con la presente remito a Ustedes, las Copias Completas de todos los Recaudos para el ANTE-PROYECTO ó PROYECTO, de la Obra denominada:", :align => :center, :styles => [:bold]
		
		move_down 8	
		bounding_box([60, cursor], :width => 420) do
			text "#{@obra.nombre}".upcase, :style => :bold, :align => :center
			stroke_horizontal_rule
		end
		move_down 13
		text_box "ÁREA BRUTA de construcción:", :at=> [0,cursor], :width => 180
		bounding_box([200, cursor], :width => 150) do
			text "#{number_porcentaje(@obra.area_bruta_construccion)}""  m2", :align => :center
			stroke_horizontal_rule
		end
		move_down 13
		text_box "Ubicada en:", :at=> [0,cursor], :width => 70
		bounding_box([100, cursor], :width => 440) do
			text "#{@obra.direccion_obra.upcase}", :align => :center
			stroke_horizontal_rule
		end
		move_down 13
		text_box "Municipio:", :at=> [0,cursor], :width => 70
		bounding_box([100, cursor], :width => 440) do
			text "#{@obra.municipio_obra.upcase}", :align => :center
			stroke_horizontal_rule
		end
		move_down 13
		text "DOCUMENTOS A CONSIGNAR PARA REVISIÓN DEL PROYECTO:", :align => :justify, :style => :bold
		text "*Memoria descriptivas y planillas multifirmas.", :align => :justify
		text "*Carta de Exposición Motivo y respectivos recaudos EN CASO DE cambio de Profesionales.", :align => :justify

		move_down 7
		text "NOTA IMPORTANTE:", :align => :justify, :style => :bold
		text "Esta planilla debidamente firmada y sellada, deberá ser anexada a los recaudos presentados a la Ingeniería Municipal respectiva.", :align => :justify
		text "*Los Profesionales son enteramente responsables ante el ente municipal y de sus clientes de sus Diseños y propuestas.", :align => :justify
		
		move_down 7
		text "OCEPRO NO SE HACE RESPONSABLE:", :align => :justify, :style => :bold
		text "Del contenido de la planimetría y material consignado por cada profesional; y la aplicación de Adecuaciones urbanas y Considereciones Impuestas por Organismos Competentes, serán de su Entera Responsabilidad.", :align => :justify

		move_down 25
		text "___________________________________________", :align => :center
		text "SELLO Y FIRMA DE O.C.E.P.R.O.N.E", :align => :center, :style => :bold
		text "Avenida Simón Bolivar - La Asunción - Estado Nueva Esparta - Teléfono: (0295) 242.26.46 / 242.02.21", :size => 7, :align => :center
		text "E-mail: ocepro@ciene1861.com", :size => 7, :align => :center
		#Comenzar nueva pagina
		#start_new_page
		


 		#table([["PROYECTO", @obra.nombre.upcase], ["PROPIETARIO", [[@obra.propietario_parcela_nombre.upcase, "RIF"]]]
 		#], :width => 500 )

 		visados = @obra.visados
 		visados.each do |visado|

 			start_new_page
 			filename = "#{Rails.root}/app/assets/images/ocepro.png"
			image filename, at: [0, 750], width: 95	
			move_up 30
			if visado.es_repeticion? 
				text " #{visado.tipo.upcase} POR REPETICIÓN", :align => :center, :size => 12, :style => :bold
			else
				text " #{visado.tipo.upcase}", :align => :center, :size => 12, :style => :bold
			end
			text " CALCULO DEL ARANCEL", :align => :center, :style => :bold
			text " VISADO ", :align => :center, :style => :bold
 			move_up 45
 			if @obra.tipo_obra.strip == "ANTEPROYECTO"
				text " #{number_numero(@obra.n_oceprone)} ANT", :align => :right, :size => 12, :style => :bold
 			elsif @obra.tipo_obra.strip == "PROYECTO"
				text "#{number_numero(@obra.n_oceprone)} PROY", :align => :right, :size => 12, :style => :bold
			end
 			text " FECHA: #{ltz(visado.created_at)}", :align => :right
 			move_down 40
 			table([
	 			["PROYECTO:", {content: @obra.nombre.upcase, colspan: 11, :align=> :center}],
	 			["PROPIETARIO:", {content: @obra.propietario_parcela_nombre.upcase, colspan: 8, :align=> :center},"RIF:",
	 				if @obra.tipo_ci_juridico.strip == "J.-" || @obra.tipo_ci_juridico.strip == "G.-"
						{ content:"#{@obra.tipo_ci_juridico}#{@obra.propietario_parcela_ci.strip} #{@obra.rif}", :align => :center, colspan:2}
					else
						{ content:"#{(@obra.tipo_ci_juridico)}#{number_numero(@obra.propietario_parcela_ci)}", :align => :center, colspan:2}
					end	
	 				],
	 			["UBICACIÓN:", {content: @obra.direccion_obra.upcase, colspan: 8, :align=> :center},"MUNICIPIO:",
	 				{content: @obra.municipio_obra.upcase, colspan:2, :align=> :center}],
	 			["ÁREA BRUTA:", {content: "#{number_porcentaje(visado.area_bruta)} m2", colspan: 8, :align=> :center},"COMPLEJ:",
	 				{content: "#{number_porcentaje(visado.complejidad)} %".to_s ,colspan: 2, :align=> :center}],
	 			[{content: "COORDINADOR PROYECTO:", colspan: 2}, {content: "#{@obra.coordinador_proyecto.nombres.upcase} #{@obra.coordinador_proyecto.apellidos.upcase}", colspan: 7, :align=> :center},"C.I.V:",
	 				{content: number_numero(@obra.coordinador_proyecto.civ), colspan:2, :align=> :center }],
	 			["RESIDENTE DE OBRA:", {content: @obra.residente_obra_nombre.upcase, colspan: 8, :align=> :center},"C.I.V:",
	 				{content: number_numero(@obra.residente_obra_civ), colspan:2, :align=> :center }]
 		
	 			], :width => 540 ,  :cell_style => {:padding => [0, 0, 0, 10]})
 			move_down 30
 			text "1) COSTO ESTIMADO DE LA OBRA:", :align => :left, :style => :bold
 			move_down 20
 			y = cursor
			bounding_box([0, y], :width => 150) do
			 	pad_top(5) {text "#{visado.area_bruta} m2", :align => :center}
			 	stroke_bounds
			end
			bounding_box([200, y], :width => 150) do
			 	pad_top(5) {text "#{number_to_bsf(visado.costo_construccion)}", :align => :center}
			 	stroke_bounds
			end
			bounding_box([400, y], :width => 150) do
			 	pad_top(5) {text "#{number_to_bsf(visado.costo_construccion_estimado)}", :align => :center}
			 	stroke_bounds
			end
			bounding_box([300, y], :width => 150) do
			 	pad_top(5) {text "=", :align => :center,:style => :bold}
			end
			bounding_box([100, y], :width => 150) do
			 	pad_top(5) {text "X", :align => :center,:style => :bold}
			end



 			 move_down 20
 			 
 			 text "2) COSTO DEL PROYECTO:", :align => :left, :style => :bold
 			 move_down 5
 			 text "A) CALCULO HONORARIOS MÍNIMOS:", :align => :left, :style => :bold
 			 move_down 10
 			 y = cursor
 			bounding_box([0, cursor], :width => 150) do
			 	pad_top(5) {text "#{number_to_bsf(visado.costo_construccion_estimado)}", :align => :center}
			 	stroke_bounds
			end
			bounding_box([100, y], :width => 150) do
			 	pad_top(5) {text "X", :align => :center,:style => :bold}
			end
			bounding_box([200, y], :width => 150) do
			 	pad_top(5) {text "#{number_porcentaje(visado.porcentaje_tabla_datos)} %", :align => :center}
			 	stroke_bounds
			end
			bounding_box([400, y], :width => 150) do
			 	pad_top(5) {text "#{number_to_bsf(visado.costo_estimado_proyecto)}", :align => :center}
			 	stroke_bounds
			end
			bounding_box([300, y], :width => 150) do
			 	pad_top(5) {text "=", :align => :center,:style => :bold}
			end
			move_down 20





 			text "B) ÍNDICE DE COMPLEJIDAD:", :align => :left, :style => :bold
 			move_down 10
 			y = cursor
 			 bounding_box([0, cursor], :width => 150) do
			 	pad_top(5) {text "#{number_to_bsf(visado.costo_estimado_proyecto)}", :align => :center}
			 	stroke_bounds
			end
			bounding_box([100, y], :width => 150) do
			 	pad_top(5) {text "X", :align => :center,:style => :bold}
			end
			bounding_box([200, y], :width => 150) do
			 	pad_top(5) {text "#{number_porcentaje(visado.complejidad)} %", :align => :center}
			 	stroke_bounds
			end
			bounding_box([400, y], :width => 150) do
			 	pad_top(5) {text "#{number_to_bsf(visado.costo_completo)}", :align => :center}
			 	stroke_bounds
			end
			bounding_box([300, y], :width => 150) do
			 	pad_top(5) {text "=", :align => :center,:style => :bold}
			end

			if visado.es_repeticion?
				move_down 10
				text "HONORARIOS POR REPETICIONES:", :style => :bold
				move_down 10
				y = cursor
				bounding_box([0, cursor], :width => 150) do
				 	pad_top(5) {text "#{number_to_bsf(visado.costo_completo)}", :align => :center}
				 	stroke_bounds
				end
				bounding_box([100, y], :width => 150) do
				 	pad_top(5) {text "X", :align => :center,:style => :bold}
				end
				bounding_box([200, y], :width => 50) do
				 	pad_top(5) {text "#{visado.complejidad} %", :align => :center}
				 	stroke_bounds
				end
				bounding_box([300, y], :width => 50) do
				 	pad_top(5) {text "#{visado.honorario_por_repeticion} %", :align => :center}
				 	stroke_bounds
				end
				bounding_box([200, y], :width => 150) do
			 		pad_top(5) {text "+", :align => :center,:style => :bold}
				end

				bounding_box([300, y], :width => 150) do
				 	pad_top(5) {text "=", :align => :center,:style => :bold}
				end
				bounding_box([400, y], :width => 150) do
				 	pad_top(5) {text "#{number_to_bsf(visado.costo_completo_repeticion)}", :align => :center}
				 	stroke_bounds
				end
			end
 			
 			move_down 20
 			text "C) ARANCEL O.C.E.P.R.O.N.E:", :align => :left, :style => :bold
 			move_down 10
 			y = cursor
 			 bounding_box([0, cursor], :width => 150) do
			 	pad_top(5) {text "#{number_to_bsf(visado.costo_completo_repeticion || visado.costo_completo)} ", :align => :center}
			 	stroke_bounds
			end
			bounding_box([100, y], :width => 150) do
			 	pad_top(5) {text "X", :align => :center,:style => :bold}
			end

			if  ( visado.costo_completo_repeticion || visado.costo_completo ) < 10000000 
				bounding_box([200, y], :width => 50) do
				 	pad_top(5) {text "1,2 %", :align => :center}
				 	stroke_bounds
				end
				bounding_box([300, y], :width => 50) do
				 	pad_top(5) {text "#{CostosCiv.last.civ * 2}", :align => :center}
				 	stroke_bounds
				end
				bounding_box([200, y], :width => 150) do
			 		pad_top(5) {text "+", :align => :center,:style => :bold}
				end
			else
				bounding_box([200, y], :width => 50) do
				 	pad_top(5) {text "1 %", :align => :center}
				 	stroke_bounds
				end
				bounding_box([300, y], :width => 50) do
				 	pad_top(5) {text "#{CostosCiv.last.civ * 6}", :align => :center}
				 	stroke_bounds
				end
				bounding_box([200, y], :width => 150) do
			 		pad_top(5) {text "+", :align => :center,:style => :bold}
				end
			end

			bounding_box([400, y], :width => 150) do
			 	pad_top(5) {text "#{number_to_bsf(visado.arancel)}", :align => :center, :style => :bold}
			 	stroke_bounds
			end
			bounding_box([300, y], :width => 150) do
			 	pad_top(5) {text "=", :align => :center,:style => :bold}
			end
 			move_down 30
 		text "OBSERVACIONES:", :style => :bold
 		text "________________________________________________________________________________"
 		text "________________________________________________________________________________"
 		text "________________________________________________________________________________"
 		text "________________________________________________________________________________"
 		move_down 45
 		text "____________________________________________", :align => :center

 		
 		text "DIRECTOR DE OCEPRO-NE", :align => :center
 		end


 		#bounding_box([0, cursor], :width => 350) do
 		#	text "Nombre: #{}"
 		#	stroke_bounds
		#end

	end
	def ltz(timestamp, options = {})
	    return nil if timestamp.blank?
	    timestamp.strftime("%d/%m/%Y")
	end

	def number_to_bsf(num)
		@view.number_to_currency(num, unit: "BsF  ", delimiter: ".", separator: ",")
	end

	def number_numero(numerito)
		@view.number_to_currency(numerito, unit: " ", delimiter: ".", precision: 0)
	end

	def number_porcentaje(numero)
		@view.number_to_currency(numero, unit: " ", delimiter: ".", separator: ",")
	end
end

