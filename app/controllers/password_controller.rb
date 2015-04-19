class PasswordController < ApplicationController

  def edit
  end

  def update
    if current_user.update(passwords_params)
      flash[:success] = t(:fl_passwd_ch)
      redirect_to root_path
    else
      flash[:danger] = t(:fl_data_err)
      render :edit
    end
  end

  private

  def passwords_params
    params.require(:passwords).permit(:password, :password_confirmation)
  end
end
