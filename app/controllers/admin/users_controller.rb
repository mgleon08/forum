class Admin::UsersController < ApplicationController

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:notice] = "編輯成功"
      redirect_to admin_topics_path
    else
      flash[:alert] = "編輯失敗"
      render "edit"
    end
  end

  protected

  def user_params
    params.require(:user).permit(:user_name,:email,:role)
  end

end
