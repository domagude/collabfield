class NotificationChannel < ApplicationCable::Channel
  def subscribed
    stream_from "notifications_#{current_user.id}"
  end

  def unsubscribed
    stop_all_streams
  end

  def contact_request_response(data)
    receiver_user_name = data['receiver_user_name']
    sender_user_name = data['sender_user_name']
    notification = data['notification']
    receiver = User.find_by(name: receiver_user_name)

    ActionCable.server.broadcast(
      "notifications_#{receiver.id}",
      notification: notification,
      sender_user_name: sender_user_name,
    )

  end
end
