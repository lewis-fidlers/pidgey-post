# Be sure to restart your server when you modify this file. Action Cable runs in a loop that does not support auto reloading.
class RoomChannel < ApplicationCable::Channel
  def subscribed
    stream_from "room_channel_#{params[:room]}"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end

  def speak(data)
    Rails.logger.info "#{current_user.email} spoke in room #{params[:room]}"
    current_user.messages.create! content: data["message"], client_id: params[:room]
  end

  def user_is_typing(data)
    ActionCable.server.broadcast "room_channel_#{params[:room]}", user: data["message"], action: "started_typing"
  end

  def user_stopped_typing(data)
    ActionCable.server.broadcast "room_channel_#{params[:room]}", user: data["message"], action: "stopped_typing"
  end
end
