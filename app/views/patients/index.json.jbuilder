json.array!(@patients) do |patient|
  json.extract! patient, :id, :first_name, :last_name, :address1, :address2, :city, :phone1, :phone2, :date_of_birth
  json.url patient_url(patient, format: :json)
end
