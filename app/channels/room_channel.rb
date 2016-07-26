# Be sure to restart your server when you modify this file. Action Cable runs in a loop that does not support auto reloading.
class RoomChannel < ApplicationCable::Channel
  def subscribed
    stream_from "room_channel_#{params[:room]}"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end

  def speak(data)
    current_user.messages.create! content: data["message"]
  end

  def user_is_typing(data)
    ActionCable.server.broadcast "room_chr{current_user}", user: data["message"], action: "started_typing"
  end

  def user_stopped_typing(data)
    ActionCable.server.broadcast "room_channel_#{current_user}", user: data["message"], action: "stopped_typing"
  end
end
