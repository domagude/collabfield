class CreateGroupConversations < ActiveRecord::Migration[5.1]
  def change
    create_table :group_conversations do |t|
      t.string :name
      t.timestamps
    end
  end
end
