class Validaciones
	@bind: ()->

		if $(".registro-usuario-helper").length > 0
			by_usuario_url = $(".registro-usuario-helper").data('by-usuario-url')
			by_mail_url = $(".registro-usuario-helper").data('by-mail-url')
			by_ci_url = $(".registro-usuario-helper").data('by-ci-url')
			by_civ_url = $(".registro-usuario-helper").data('by-civ-url')

			$(".test").validate({
				rules:{
					"usuario[usuario]":{ 
						remote: by_usuario_url
					},
					"usuario[email]":{ 
						remote: by_mail_url
					},
					"usuario[cedula]":{ 
						checkci: true,
						remote: by_ci_url
					},
					"usuario[civ]":{ 
						remote: by_civ_url
					}
				},
				messages:{
					"usuario[usuario]": 
						remote: "Usuario ya existe en el sistema",
					"usuario[email]": 
						remote: "Correo existe en el sistema",
					"usuario[cedula]": 
						checkci: "Formato de cédula no  válido"
						remote:"Número de cédula existe en el sistema",
					"usuario[civ]": 
						remote:"Número de C.I.V existe en el sistema",
				},
			
			})
			$(".tipo-ci").on  'change', () ->
				$("#cedula").trigger('blur')

		if $(".modificar-usuario-helper").length > 0
			console.log 'Helper???', $(".edit_usuario")
			by_mail_url = $(".modificar-usuario-helper").data('by-mail-url')
			by_ci_url = $(".modificar-usuario-helper").data('by-ci-url')
			by_civ_url = $(".modificar-usuario-helper").data('by-civ-url')
			console.log  by_mail_url,

			$(".edit_usuario").validate({
				rules:{
					"usuario[email]":{ 
						remote: by_mail_url
					},
					"usuario[cedula]":{ 
						checkci: true,
						remote: by_ci_url
					},
					"usuario[civ]":{ 
						remote: by_civ_url
					}
				},
				messages:{
					"usuario[email]": 
						remote: "Correo existe en el sistema",
					"usuario[cedula]": 
						checkci: "Formato de cédula no  válido"
						remote:"Número de cédula existe en el sistema",
					"usuario[civ]": 
						remote:"Número de C.I.V existe en el sistema",
				},
			
			})
			$(".tipo-ci").on  'change', () ->
				$("#cedula").trigger('blur')




$ ()->
	Validaciones.bind()

