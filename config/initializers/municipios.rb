MUNICIPIOS = [
'Antolin',
'Arismendi',
'Diaz',
'Garcia',
'Gomez',
'Maneiro',
'Marcano',
'Marino',
'Macanao',
'Tubores',
'Villalba',
]

def ltz(timestamp)
  return nil if timestamp.blank?
  timestamp.strftime("%d/%m/%Y")
end
