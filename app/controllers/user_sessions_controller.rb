class UserSessionsController < ApplicationController
  skip_before_filter :require_login, except: [:destroy]

  def new
    @user = User.new
  end

  def create
    if @user = login(params[:email], params[:password])
      redirect_back_or_to root_path, success: "Добро пожаловать!"
    else
      flash.now[:danger] = "Неправильный логин или пароль!"
      render :new
    end
  end

  def destroy
    logout
    redirect_to root_path, success: "Вы вышли из системы"
  end
end