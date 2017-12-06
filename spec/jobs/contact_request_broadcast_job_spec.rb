require "rails_helper"

RSpec.describe ContactRequestBroadcastJob, :type => :job do
	context '#perform_later' do
		let(:contact_request) { create(:contact) }

		it 'enqueues a job' do
			ActiveJob::Base.queue_adapter = :test
      expect {
      	contact_request
    	}.to have_enqueued_job
		end
	end
end