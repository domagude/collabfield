require "rails_helper"

RSpec.describe Private::MessageBroadcastJob, :type => :job do
  context '#perform_later' do
    let(:message) { create(:private_message) }

    it 'enqueues a job' do
      ActiveJob::Base.queue_adapter = :test
      expect {
        message
      }.to have_enqueued_job
    end
  end
end