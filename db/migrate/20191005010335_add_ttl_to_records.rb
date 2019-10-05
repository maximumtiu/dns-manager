class AddTtlToRecords < ActiveRecord::Migration[5.2]
  def change
    add_column :records, :ttl, :integer
  end
end
