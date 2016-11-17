class Validacion_civ
  @bind: ()->
    $('.role').on 'change', () ->
      if $('.role').val().trim() == "agremiado" 
        $('#identidad').show()
      else
        $('#identidad').hide()
        $('.identificador').val("")
$ ()->
  Validacion_civ.bind()