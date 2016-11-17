class Validaciones_obras
	@bind: ()->
		if $(".registro-oceprone-helper").length > 0
			by_obras_url = $(".registro-oceprone-helper").data('by-obras-url')

		

			$(".ocepro-form").validate({
				rules:{
					"obra[n_oceprone]":{ 
						remote: by_obras_url
					},
					
				},
				messages:{
					"obra[n_oceprone]": {
						remote: "Expediente existente",
					},
					
				},
			
			})

$ ()->
	Validaciones_obras.bind()