class CreateGroupMessages < ActiveRecord::Migration[5.1]
  def change
    create_table :group_messages do |t|
      t.string :content
      t.string :added_new_users
      t.string :seen_by
      t.belongs_to :user, index: true
      t.belongs_to :conversation, index: true
      t.timestamps
    end
  end
end
