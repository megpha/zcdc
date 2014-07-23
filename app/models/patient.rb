class Patient < ActiveRecord::Base
  has_many :appointments

  def full_name
    result = ["#{first_name}, #{last_name}"]
    result.push(" (#{age})") if age.present?
    result.join
  end

  def age
    return unless date_of_birth.present?
    now = Time.now.utc.to_date
    now.year - date_of_birth.year - (date_of_birth.to_date.change(year: now.year, day: 1) > now ? 1 : 0)
  end
end
