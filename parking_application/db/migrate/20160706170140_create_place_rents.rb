class CreatePlaceRents < ActiveRecord::Migration
  def change
    create_table :place_rents do |t|
      t.datetime :start_date
      t.datetime :end_date
      t.decimal :price
      t.integer :parking_id
      t.integer :car_id

      t.timestamps null: false
    end
  end
end
