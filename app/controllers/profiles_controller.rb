class ProfilesController < ApplicationController
  def index
    @user = User.find(current_user)
  end

  def edit
    @user = User.find(current_user)
  end

  def update
    @user = User.find(current_user)
    if @user.update(user_params)
      flash[:notice] = "編輯成功"
      redirect_to profiles_path
    else
      flash.now[:alert] = "編輯失敗(不能留空白)"
      render "edit"
    end
  end

  protected

  def user_params
    params.require(:user).permit(:profile)
  end
end
