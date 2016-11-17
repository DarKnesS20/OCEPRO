json.array!(@honorario_minimos) do |honorario_minimo|
  json.extract! honorario_minimo, :id, :concepto, :desde, :hasta, :porcentaje, :create_by
  json.url honorario_minimo_url(honorario_minimo, format: :json)
end
