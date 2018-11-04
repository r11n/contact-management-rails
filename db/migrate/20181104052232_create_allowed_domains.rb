class CreateAllowedDomains < ActiveRecord::Migration[5.2]
  def change
    create_table :allowed_domains do |t|
      t.string :domain, unique: true
      t.timestamps
    end
  end
end
