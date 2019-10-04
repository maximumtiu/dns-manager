class CreateRecords < ActiveRecord::Migration[5.2]
  def change
    create_table :records do |t|
      t.integer :zone_id
      t.string :type
      t.text :rdata

      t.timestamps
    end
  end
end
