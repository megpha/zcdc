json.array!(@hospitals) do |hospital|
  json.extract! hospital, :id, :name, :address1, :address2, :city, :phone1, :phone2
  json.url hospital_url(hospital, format: :json)
end
