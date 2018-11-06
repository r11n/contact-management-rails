class RenameTypeInContactAttributes < ActiveRecord::Migration[5.2]
  def change
    rename_column :contact_numbers, :type, :contact_type
    rename_column :contact_emails, :type, :contact_type
    rename_column :contact_addresses, :type, :contact_type
  end
end
