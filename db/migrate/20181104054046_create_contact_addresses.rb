class CreateContactAddresses < ActiveRecord::Migration[5.2]
  def change
    create_table :contact_addresses do |t|
      t.string :type
      t.references :contact, foreign_key: true
      t.string :address

      t.timestamps
    end
  end
end
