class FriendshipsController < ApplicationController
  def create
    @friendship = current_user.friendships.build(friend_id: params[:friend_id])
    if @friendship.save
      flash[:notice] = 'Friend requested.'
    else
      flash[:error] = 'Unable to request friendship.'
    end
    redirect_to :back
  end

  def update
    @friendship =
      Friendship.find_by(friend_id: current_user.id, user_id: params[:id])
    @friendship.update(accepted: true)
    if @friendship.save
      redirect_to root_url, notice: 'Successfully confirmed friend!'
    else
      redirect_to root_url, notice: 'Sorry! Could not confirm friend!'
    end
  end

  def destroy
    if awaiting_request.present? || sent_request.present?
      @friendship.destroy
      flash[:notice] = 'Removed friendship.'
    end
    redirect_to :back
  end

  def awaiting_request
    @friendship =
      Friendship.find_by(user_id: params[:id], friend_id: current_user.id)
  end

  def sent_request
    @friendship =
      Friendship.find_by(friend_id: params[:id], user_id: current_user.id)
  end
end
