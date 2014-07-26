class Appointment < ActiveRecord::Base
  belongs_to :patient
  has_many :attachments, as: :attachable
  accepts_nested_attributes_for :attachments
  scope :active, -> { where(completed_at: nil) }
  scope :completed, -> { where("completed_at is not null") }


  #validates :patient_id, :uniqueness => true

  #validates_uniqueness_of :patient_id, :scope => :starts_at

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

  def completed!
    touch(:completed_at)
  end
end
