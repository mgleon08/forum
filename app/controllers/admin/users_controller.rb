class Admin::UsersController < ApplicationController

  before_action :check_admin

  def edit
    @user = User.find_by_user_name(params[:id])
  end

  def update
    @user = User.find_by_user_name(params[:id])
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
    params.require(:user).permit(:user_name,:email,:role,:profile)
  end

  def check_admin
    unless current_user.role == "admin"
      raise ActiveRecord::RecordNotFound #導向404
      redirect_to root_path
    end
  end

end
