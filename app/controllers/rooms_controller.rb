class RoomsController < ApplicationController
  def show
    @active_user = current_user
    @messages = Message.all
  end
end
