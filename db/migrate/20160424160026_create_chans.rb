class CreateChans < ActiveRecord::Migration
  def change
    create_table :chans do |t|


    	t.string   :chan_date
    	t.string :chan_type
    	t.text   :food

      t.timestamps null: false
    end
  end
end
