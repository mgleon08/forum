class ProfilesController < ApplicationController
  def index
    @user = current_user
    @profile = @user.build_profile(:user_profile => "請點選編輯更改個人簡介")
  end

  def edit
  end

  def update
  end
end
