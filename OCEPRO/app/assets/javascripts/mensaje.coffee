class MensajeMultifirma
  @bind: ()->

    $("#multifirmoso").on 'click', (evt) ->

      swal("Atención!", "La planilla debe ser anexada en el archivo memoria descritiva de no hacerlo su proyecto NO SERA APROBADO.", "info")

$ ()->
  MensajeMultifirma.bind()