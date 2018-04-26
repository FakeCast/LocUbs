class CreateUnidades < ActiveRecord::Migration
  def change
    create_table :unidades do |t|
      t.string :name
      t.string :address
      t.string :city
      t.string :phone
      t.float :geocode_lat
      t.float :geocode_long
      t.integer :scores_size
      t.integer :scores_adaptation_for_seniors
      t.integer :scores_medical_equipment
      t.integer :scores_medicine

      t.timestamps null: false
    end
  end
end
