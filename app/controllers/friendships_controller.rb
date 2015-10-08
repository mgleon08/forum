class FriendshipsController < ApplicationController

  def create
    @friend = User.find(params[:friend_id])
    if params[:select]
      if params[:select]== "yes"
        @friendship = Friendship.find_by(:user=>@friend, :friend=>current_user).update(:status=>"好友")
        if Friendship.find_by(:user_id=>current_user.id , :friend_id => @friend.id)
         Friendship.find_by(:user_id=>current_user.id , :friend_id => @friend.id).update(:status=>"好友")
        else
         Friendship.create(:user_id=>current_user.id , :friend_id => @friend.id , :status=>"好友")
       end
        flash[:notice] = "已成為好友"
        redirect_to :back
      else
        @friendship = Friendship.find_by(:user=>params[:friend_id], :friend=>current_user.id).update(:status=>"拒絕")

        flash[:alert] = "拒絕成功"
        redirect_to :back
      end
    else
      if @friend != current_user && !current_user.my_friends?(@friend)
        current_user.friendships.create( :friend => @friend,:status=>"邀請")

        flash[:notice] = "提出邀請"
        redirect_to :back
      else

        flash[:alert] = "不能加好友"
        redirect_to :back
      end
    end
  end

  def destroy
    @friend = User.find(params[:friend_id])
    @friendship = current_user.friendships.find(params[:id])

    @friendship.destroy
    flash[:alert] = "Removed friendship."
    redirect_to :back
  end


  private
  def friendship_params
    params.require(:friendship).permit(:status)
  end
end
