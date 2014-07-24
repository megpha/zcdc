class Appointment < ActiveRecord::Base
  belongs_to :patient
  has_many :attachments, as: :attachable
  accepts_nested_attributes_for :attachments

  def self.on(date)
    date    = date.in_time_zone(Time.zone)
    to      = date.beginning_of_day
    from    = date.end_of_day

    where("starts_at between ? and ?", to, from)
  end

  def self.next(date = Date.today)
    date    = date.in_time_zone(Time.zone)
    to      = date.beginning_of_day
    result  = on(to).maximum(:starts_at)

    result.nil? ? (to + 10.hours) : result + 10.minutes
  end
end
