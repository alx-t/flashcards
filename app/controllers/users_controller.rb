class UsersController < ApplicationController

  def index
    @users = User.all
  end

  def update
    if current_user.update(user_params)
      flash[:success] = "Пользователь обновлен!"
      redirect_to root_path
    else
      flash.now[:danger] = "Ошибка в данных!"
      render :edit
    end
  end

  def destroy
    current_user.destroy
    flash[:success] = "Пользователь удален!"
    redirect_to root_path
  end

  def set_current_pack
    current_user.update_attributes(current_pack_id: params[:current_pack_id])
    redirect_to packs_path
  end

  def reset_current_pack
    current_user.update_attributes(current_pack: nil)
    redirect_to packs_path
  end

  private

  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation)
  end
end
