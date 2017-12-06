class CreatePrivateConversations < ActiveRecord::Migration[5.1]
  def change
    create_table :private_conversations do |t|
      t.integer :recipient_id
      t.integer :sender_id

      t.timestamps
    end
    add_index :private_conversations, :recipient_id
    add_index :private_conversations, :sender_id
    add_index :private_conversations, [:recipient_id, :sender_id], unique: true
  end
end

