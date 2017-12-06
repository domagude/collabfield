class CreateContacts < ActiveRecord::Migration[5.1]
  def change
    create_table :contacts do |t|
      t.belongs_to :user, index: true
      t.belongs_to :contact, index: true
      t.boolean :accepted, default: false

      t.timestamps
    end
  end
end