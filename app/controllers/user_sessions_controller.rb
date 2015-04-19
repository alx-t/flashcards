class UserSessionsController < ApplicationController
  skip_before_action :require_login, except: [:destroy]

  def new
    @user = User.new
  end

  def create
    if @user = login(params[:email], params[:password])
      redirect_back_or_to root_path, success: t(:fl_welcome)
    else
      flash.now[:danger] = t(:fl_data_err)
      render :new
    end
  end

  def destroy
    logout
    redirect_to root_path, success: t(:fl_logout)
  end
end
