class PacksController < ApplicationController
  before_action :set_pack, only: [:show, :edit, :update, :destroy]

  def index
    @packs = current_user.packs
  end

  def new
    @pack = current_user.packs.new
  end

  def create
    @pack = current_user.packs.build(title: pack_params[:title],
                                     current: pack_params[:current] == "true")
    if @pack.save
      if pack_params["current"] == "true"
        @pack.user.update_attributes(current_pack: @pack)
      end
      flash[:success] = "Колода создана!"
      redirect_to packs_path
    else
      render :new
    end
  end

  def update
    if @pack.update(title: pack_params[:title],
                    current: pack_params[:current] == "true")
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

  def toggle_current_pack
    new_current_pack = current_user.packs.find(params[:pack])
    new_current_pack = (current_user.current_pack_id == new_current_pack.id) \
      ? nil : new_current_pack
    current_user.update_attributes(current_pack: new_current_pack)
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
