$ ()->
	$('#obra_tipo_obra').on 'change', () ->
		console.log 'aaaa', this, $(this), this.value
		if this.value.trim() == 'PROYECTO'
			console.log 
			$('#num_ocepro').show();
		else
			$('#num_ocepro').hide();
			$('#obra_n_oceprone').val("")




