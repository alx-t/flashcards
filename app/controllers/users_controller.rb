class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  skip_before_filter :require_login, only: [:index, :new, :create]

  def index
    @users = User.all
  end

  def show
  end

  def new
    @user = User.new
  end

  def edit
  end

  def create
    @user = User.new(user_params)
    if @user.save
      auto_login(@user)
      flash[:success] = "Пользователь зарегистрирован!"
      redirect_to root_path
    else
      flash.now[:danger] = "Ошибка в данных!"
      render :new
    end
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
      @user = User.find(params[:id])
    end

    def user_params
      params.require(:user).permit(:email, :password, :password_confirmation)
    end
end
