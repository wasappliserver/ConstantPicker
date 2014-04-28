json.array!(@couleurs) do |couleur|
  json.extract! couleur, :id, :title, :coul_type, :value_coul
  json.url couleur_url(couleur, format: :json)
end
