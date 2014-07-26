class Patient < ActiveRecord::Base
  has_many :appointments
  paginates_per 20
  #fuzzily_searchable :full_name

  def full_name
    "#{first_name} #{last_name}"
  end

  def age
    return unless date_of_birth.present?
    now = Time.now.utc.to_date
    now.year - date_of_birth.year - (date_of_birth.to_date.change(year: now.year, day: 1) > now ? 1 : 0)
  end

  def current_appointment
    appointments.last || appointments.create
  end

  def past_appointments
    appointments.to_a - [current_appointment]
  end
end
