json.array!(@localizables) do |localizable|
  json.extract! localizable, :id, :key, :value, :lang, :app_id, :missing
  json.url localizable_url(localizable, format: :json)
end
