class CreateGroupConversationsUsersJoinTable < ActiveRecord::Migration[5.1]
  def change
    create_table :group_conversations_users, id: false do |t|
      t.integer :conversation_id
      t.integer :user_id
    end
    add_index :group_conversations_users, :conversation_id
    add_index :group_conversations_users, :user_id
  end
end
