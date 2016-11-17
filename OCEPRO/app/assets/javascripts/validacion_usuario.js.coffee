class Validacion_usuario
  @bind: ()->
    $('.tipoci').on 'change', () ->
      if $('.tipoci').val().trim() == "G.-" || $('.tipoci').val().trim() == "J.-"
        $('#ru').show()
      else
        $('#ru').hide()
        $('.ro').val("")
$ ()->
  Validacion_usuario.bind()