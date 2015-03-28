class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]

  def index
    @users = User.all
  end

  def show
  end

  def edit
  end

  def update
    if @user.update(user_params)
      flash[:success] = "Пользователь обновлен!"
      redirect_to root_path
    else
      flash.now[:danger] = "Ошибка в данных!"
      render :edit
    end
  end

  def destroy
    @user.destroy
    flash[:success] = "Пользователь удален!"
    redirect_to root_path
  end

  private

    def set_user
      @user = current_user
    end

    def user_params
      params.require(:user).permit(:email, :password, :password_confirmation)
    end
end
