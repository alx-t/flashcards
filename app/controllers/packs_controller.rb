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
      @pack.user.update_attribute(:current_pack, @pack) if pack_params["current"] == "1"
      flash[:success] = "Колода создана!"
      redirect_to packs_path
    else
      render :new
    end
  end

  def update
    if @pack.update(pack_params)
      flash[:success] = "Колода обновлена!"
      redirect_to packs_path
    else
      render :new
    end
  end

  def destroy
    @pack.destroy
    flash[:success] = "Колода удалена!"
    redirect_to packs_path
  end

  private
    def set_pack
      @pack = current_user.packs.find(params[:id])
    end

    def pack_params
      params.require(:pack).permit(:title, :current)
    end
end