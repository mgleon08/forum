class IntroductionsController < ApplicationController

  def show
    if params[:id]
      @user = User.find(params[:id])
    else
      @user = current_user
    end
  end

  def edit
    @user = current_user
    @user.create_introduction unless @user.introduction
  end

  def update
    @user = current_user
    @user.create_introduction unless @user.introduction

    if @user.introduction.update(intro_params)
      flash[:notice] = "編輯成功"
      redirect_to introduction_path(@user)
    else
      flash.now[:alert] = "編輯失敗(不能留空白)"
      render "edit"
    end
  end


  protected

  def intro_params
    params.require(:introduction).permit(:pro)
  end

end
