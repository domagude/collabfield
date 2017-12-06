FactoryGirl.define do
  factory :private_conversation, class: 'Private::Conversation' do
    association :recipient, factory: :user
    association :sender, factory: :user

    factory :private_conversation_with_messages do
      transient do
        messages_count 1
      end

      after(:create) do |private_conversation, evaluator|
        create_list(:private_message, evaluator.messages_count, 
                     conversation: private_conversation)
      end
    end
  end
end
