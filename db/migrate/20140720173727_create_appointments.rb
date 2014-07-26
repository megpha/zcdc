class CreateAppointments < ActiveRecord::Migration
  def change
    create_table :appointments do |t|
      t.datetime :starts_at
      t.datetime :completed_at
      t.float :blood_pressure
      t.float :weight_in_kgs
      t.float :height_in_cms
      t.string :issue
      t.string :prescription
      t.string :notes
      t.references :patient, index: true

      t.timestamps
    end
  end
end
