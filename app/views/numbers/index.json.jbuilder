json.array!(@numbers) do |number|
  json.extract! number, :id, :title, :value
  json.url number_url(number, format: :json)
end
