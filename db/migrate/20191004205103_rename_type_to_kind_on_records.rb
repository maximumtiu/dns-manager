class RenameTypeToKindOnRecords < ActiveRecord::Migration[5.2]
  def change
    rename_column :records, :type, :type_of
  end
end
