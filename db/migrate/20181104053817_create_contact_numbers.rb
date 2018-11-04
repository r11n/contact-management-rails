class CreateContactNumbers < ActiveRecord::Migration[5.2]
  def change
    create_table :contact_numbers do |t|
      t.string :type
      t.references :contact, foreign_key: true
      t.string :number

      t.timestamps
    end
  end
end
