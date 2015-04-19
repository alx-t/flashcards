class PacksController < ApplicationController
  before_action :set_pack, only: [:show, :edit, :update, :destroy]

  def index
    @packs = current_user.packs
  end

  def new
    @pack = current_user.packs.new
  end

  def create
    @pack = current_user.packs.build(pack_params)
    if @pack.save
      flash[:success] = t(:fl_pack_add)
      redirect_to packs_path
    else
      render :new
    end
  end

  def update
    if @pack.update(pack_params)
      flash[:success] = t(:fl_pack_edit)
      redirect_to packs_path
    else
      render :new
    end
  end

  def destroy
    @pack.destroy
    flash[:success] = t(:fl_pack_delete)
    redirect_to packs_path
  end

  private

  def set_pack
    @pack = current_user.packs.find(params[:id])
  end

  def pack_params
    params.require(:pack).permit(:title)
  end
end
