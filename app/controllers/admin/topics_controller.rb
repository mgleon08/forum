class Admin::TopicsController < ApplicationController

  before_action :check_admin

  def index
    @users = User.all
    @categories = Category.all
  end

  protected

  def check_admin
    unless current_user.role == "admin"
      raise ActiveRecord::RecordNotFound #導向404
      redirect_to root_path
    end
  end

end
