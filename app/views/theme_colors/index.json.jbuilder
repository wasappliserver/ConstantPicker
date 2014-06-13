json.array!(@theme_colors) do |theme_color|
  json.extract! theme_color, :id, :app_id, :color
  json.url theme_color_url(theme_color, format: :json)
end
