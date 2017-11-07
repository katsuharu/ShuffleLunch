class RoomChannel < ApplicationCable::Channel
  def subscribed
    stream_for "room_channel_#{matching_id}"
    Message.create!(user_id: current_user.try(:id), content: "#{current_user.try(:name)}が入室しました。", matching_id: matching_id) if matching_id.present?
  end

  def unsubscribed
    Message.create!(user_id: current_user.try(:id), content: "#{current_user.try(:name)}が退室しました。", matching_id: matching_id) if matching_id.present?
  end

  def speak message
    Message.create!(user_id: current_user.try(:id), content: message['content'], matching_id: matching_id)
  end

end