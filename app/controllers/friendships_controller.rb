class FriendshipsController < ApplicationController

  def create
    if  params[:friend_id] != current_user.id.to_s && current_user.my_friends?(params[:friend_id])
      byebug
      @friendship = current_user.friendships.build(:friend_id => params[:friend_id])
      @friendship.save
      flash[:notice] = "ADD friend"
      redirect_to :back
    else
       flash[:alert] = "不能加好友"
      puts "daj"
      redirect_to :back
    end
  end

  def destroy
    @friendship = current_user.friendships.find(params[:id])
    @friendship.destroy
    flash[:alert] = "Removed friendship."
    redirect_to :back
  end
end
