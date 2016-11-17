
jQuery.validator.addMethod("checkci", ((value, elem) ->
	console.log value, elem
	tipo =  $(".tipo-ci").val().trim()
	value = parseInt(value)
	console.log tipo, value, typeof value,tipo == "V.-" ,  tipo == "E.-"
	if tipo == "V.-" && value >= 80000000
		console.log 'F', tipo
		return false
	else if tipo == "E.-" && value <= 80000000
		console.log 'F'
		return false
	else
		console.log 'T'
		return true

	), "Formato de cédula no válido")


jQuery.validator.addMethod("checkciv2", ((value, elem) ->
	console.log value, elem
	tipo =  $(".tipo-ci-v2").val().trim()
	value = parseInt(value)
	console.log tipo, value, typeof value,tipo == "V.-" ,  tipo == "E.-"
	if tipo == "V.-" && value >= 80000000
		console.log 'F', tipo
		return false
	else if tipo == "E.-" && value <= 80000000
		console.log 'F'
		return false
	else
		console.log 'T'
		return true

	), "Formato de cédula no válido")

jQuery.validator.addMethod("areabruta", ((value, elem) ->
	console.log value, elem
	area =  parseFloat($("#obra_area_parcela").val())
	console.log typeof area
	value = parseFloat(value)
	console.log 'val', value, area >= value, area
	if area <= value
		return false
	else
		return true
	), "Área bruta no puede ser mayor o igual al tamaño de la parcela")

jQuery.validator.addMethod("areaneta", ((value, elem) ->
	console.log value, elem
	area =  parseFloat($("#obra_area_parcela").val())
	console.log typeof area
	value = parseFloat(value)
	console.log 'val', value, area >= value, area
	if area <= value
		return false
	else
		return true
	), "Área neta no puede ser mayor o igual al tamaño de la parcela")
		
