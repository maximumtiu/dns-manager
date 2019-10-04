class CreateZones < ActiveRecord::Migration[5.2]
  def change
    create_table :zones do |t|
      t.string :zone
      t.text :dns_servers, array: true, default: []

      t.timestamps
    end
  end
end
