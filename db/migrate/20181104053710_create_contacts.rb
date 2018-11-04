class CreateContacts < ActiveRecord::Migration[5.2]
  def change
    create_table :contacts do |t|
      t.string :name
      t.references :group, foreign_key: true
      t.references :user, foreign_key: true
      t.boolean :is_favorite

      t.timestamps
    end
  end
end
