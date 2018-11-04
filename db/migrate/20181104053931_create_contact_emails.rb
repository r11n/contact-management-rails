class CreateContactEmails < ActiveRecord::Migration[5.2]
  def change
    create_table :contact_emails do |t|
      t.string :type
      t.references :contact, foreign_key: true
      t.string :email

      t.timestamps
    end
  end
end
