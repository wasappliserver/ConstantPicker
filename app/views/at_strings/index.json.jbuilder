json.array!(@at_strings) do |at_string|
  json.extract! at_string, :id, :title, :value
  json.url at_string_url(at_string, format: :json)
end
