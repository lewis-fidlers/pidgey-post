class RoomsController < ApplicationController
  def show
    # TODO: where recipient_id = params[:id] // Or somehting like that
    @messages = Message.all
    @room_id = params[:id]
    @active_user = current_user
    return render text: "Not allowed" if current_user.id.to_s != params[:id] && current_user.client?
  end

  def index
    return redirect_to room_path(id: current_user.id) if current_user.client?

    @users = User.where(role: "client")
    return render :index if current_user.guide?
    render text: "oh ow you have no role"
  end
end
