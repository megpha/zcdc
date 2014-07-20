class CreateAppointments < ActiveRecord::Migration
  def change
    create_table :appointments do |t|
      t.datetime :starts_at
      t.references :patient, index: true

      t.timestamps
    end
  end
end
