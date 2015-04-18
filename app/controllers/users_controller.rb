class UsersController < ApplicationController

  def index
    @users = User.all
  end

  def update
    if current_user.update(user_params)
      flash[:success] = t(:fl_user_edit)
      redirect_to root_path
    else
      flash.now[:danger] = t(:fl_data_err)
      render :edit
    end
  end

  def destroy
    current_user.destroy
    flash[:success] = t(:fl_user_del)
    redirect_to root_path
  end

  def set_current_pack
    current_user.update_attributes(current_pack_id: params[:current_pack_id])
    redirect_to packs_path
  end

  def reset_current_pack
    current_user.update_attributes(current_pack_id: nil)
    redirect_to packs_path
  end

  private

  def user_params
    params.require(:user).permit(:email, :locale, :password, :password_confirmation)
  end
end
