json.array!(@patients) do |patient|
  json.extract! patient, :id, :full_name
  json.url patient_url(patient)
end
