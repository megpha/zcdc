class CreatePatients < ActiveRecord::Migration
  def change
    create_table :patients do |t|
      t.string :first_name
      t.string :last_name
      t.string :address1
      t.string :address2
      t.string :city
      t.string :phone1
      t.string :phone2
      t.date :date_of_birth

      t.timestamps
    end
  end
end
