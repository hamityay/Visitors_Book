class PlacesController < ApplicationController
  before_action :set_place, only: [:show, :edit, :update, :destroy]

  def index
    @places = Place.all.includes(:subcategory, :city)
  end

  def new
    @place = Place.new
  end

  def create
    @place = Place.create(place_params)
    if @place.save!
      flash[:notice] = "Başarılı bir şekilde Mekan tavsiyesi gönderildi."
      redirect_to root_path
    else
      flash[:alert] = "Hatalı bir işlem gerçekleştirdiniz."
      redirect_to back
    end
  end

  def show
  end

  def edit
  end

  def update
    @place.update(place_params)
    if @place.save!
      flash[:notice] = "Başarılı bir şekilde Mekan bilgileri güncellendi."
      redirect_to place_path(@place)
    else
      flash[:alert] = "Hatalı bir işlem gerçekleştirdiniz."
      redirect_to back
    end
  end

  def destroy
  end

  def visit
    p_user = Place.find(params[:place_id])
    current_user.places << p_user
    redirect_to p_user, notice: "Ziyaret ettiklerinize eklendi."
  end

  private
    def place_params
      params.require(:place).permit(:name, :address, :description, :phone, :email,
                                    :subcategory_id, :country_id, :city_id)
    end

    def set_place
      @place = Place.find(params[:id])
    end
end
