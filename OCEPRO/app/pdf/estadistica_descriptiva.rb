class EstadisticaDescriptiva < Prawn::Document
	def initialize(año,obras,view,media,mediana,desviacion,varianza,moda,usuario)
		super(top_margin: 70)
		#Variables declaradas en el controlador que se pasan por parámetro al crear el objeto Regresion lineal
		@obras = obras
		@media=media
		@mediana=mediana
		@desviacion=desviacion
		@varianza=varianza
		@moda=moda
		@usuario = usuario
		@view = view
		todo_junto_test
		@año_actual=año
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
		text " REPORTE DE ESTADÍSTICA DESCRIPTIVA "+@año_actual.to_s+"", :align => :center, :size => 16
		move_down 20
		data = tabla
		# creación de tabla
		table(data, :width => 540 ,  :cell_style => {:padding => [0, 0, 0, 10]}) 
		move_down 30
		text " EMITIDO POR: #{@usuario.nombres.upcase} #{@usuario.apellidos.upcase}", :align => :center
	end

	def tabla
		data = [
				[{content: "VARIABLE ESTADÍSTICA", colspan: 3, :align=> :center}, 
				{content: "RESULTADO OBTENIDO", colspan: 3, :align=> :center}
				],
				[
					{content: "MEDIA",  colspan: 3, :align=> :center},
					{content: " #{number_numero(@media)}",  colspan: 3, :align=> :center}],
				[
					{content: "MEDIANA",  colspan: 3, :align=> :center},
					{content: " #{number_numero(@mediana)}",  colspan: 3, :align=> :center}],
				[
					{content: "DESVIACIÓN ESTÁNDAR",  colspan: 3, :align=> :center},
					{content: " #{number_numero(@desviacion)}",  colspan: 3, :align=> :center}],
				[
					{content: "VARIANZA",  colspan: 3, :align=> :center},
					{content: " #{number_numero(@varianza)}",  colspan: 3, :align=> :center}],
				[
					{content: "MODA",  colspan: 3, :align=> :center},
					{content: " #{@moda}" ,colspan: 3, :align=> :center}]
			]
		data
	end
	def number_numero(numerito)
		@view.number_to_currency(numerito, unit: " ", delimiter: ".", precision: 2, separator: ",")
	end

	def number_porcentaje(numero)
		@view.number_to_currency(numero, unit: " ", delimiter: ".", separator: ",", precision: 2)
	end
end
