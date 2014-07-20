class CreateHospitals < ActiveRecord::Migration
  def change
    create_table :hospitals do |t|
      t.string :name
      t.string :address1
      t.string :address2
      t.string :city
      t.string :phone1
      t.string :phone2

      t.timestamps
    end
  end
end
