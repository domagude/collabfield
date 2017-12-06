class ContactRequestBroadcastJob < ApplicationJob
  queue_as :default

  def perform(contact_request)

    sender = User.find(contact_request.user_id)
    receiver = User.find(contact_request.contact_id)
    ActionCable.server.broadcast(
      "notifications_#{receiver.id}",
      notification: 'contact-request-received',
      sender_name: sender.name,
      contact_request: render_contact_request(sender, contact_request)
    )

  end

  private

  def render_contact_request(sender, contact_request)
    ApplicationController.render(
      partial: 'contacts/contact_request',
      locals: { sender: sender }
    )
  end

end
