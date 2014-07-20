class Appointment < ActiveRecord::Base
  belongs_to :patient
  has_many :attachments, as: :attachable
  accepts_nested_attributes_for :attachments
end
