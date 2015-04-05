class ChangePasswordController < ApplicationController

  def edit
  end

  def update
    if current_user.update(user_params)
      flash[:success] = "Пароль изменен!"
      redirect_to root_path
    else
      flash[:danger] = "Ошибка в данных!"
      render :edit
    end
  end

  private

    def user_params
      params.require(:user).permit(:password, :password_confirmation)
    end
end
