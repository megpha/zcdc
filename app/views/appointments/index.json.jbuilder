json.array!(@appointments) do |appointment|
  json.extract! appointment, :id, :starts_at, :patient_id
  json.url appointment_url(appointment, format: :json)
end
