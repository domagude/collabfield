class Private::Message < ApplicationRecord
  self.table_name = "private_messages"
  after_create_commit do 
    Private::MessageBroadcastJob.perform_later(self, previous_message)
  end
  belongs_to :user
  belongs_to :conversation, 
             class_name: 'Private::Conversation',
             foreign_key: :conversation_id

  validates :body, presence: true
  validates :user_id, presence: true

  def previous_message
    previous_message_index = self.conversation.messages.index(self) - 1
    self.conversation.messages[previous_message_index]
  end
end
