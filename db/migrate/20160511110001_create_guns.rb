class CreateGuns < ActiveRecord::Migration
  def change
    create_table :guns do |t|
    	t.string   :gun_date
    	t.string :gun_type
    	t.text   :food
      t.timestamps null: false
    end
  end
end
