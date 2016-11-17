###class MensajeAreabruta
  @bind: ()->
    $('.bruta').on 'blur', () ->
      if $(".bruta").val() >= $(".parcela").val()
        sweetAlert("Error!", "El área bruta no puede ser mayor o igual al tamano de la parcela", "error")
        $(".bruta").val("")

    $('.neta').on 'blur', () ->
      if $(".neta").val() >= $(".parcela").val()
        sweetAlert("Error!", "El área neta no puede ser mayor o igual al tamano de la parcela", "error")
        $(".neta").val("")
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

$ ()->
  MensajeAreabruta.bind()###