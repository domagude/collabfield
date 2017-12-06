require "rails_helper"

RSpec.describe Group::MessageBroadcastJob, :type => :job do
  context '#perform_later' do
    let(:message) { create(:group_message) }
    let(:previous_message) { create(:group_message) }
    let(:current_user) { create(:user) }

    it 'enqueues a job' do
      ActiveJob::Base.queue_adapter = :test
      expect {
        Group::MessageBroadcastJob.perform_later(message, previous_message, current_user)
      }.to have_enqueued_job
    end
  end
end