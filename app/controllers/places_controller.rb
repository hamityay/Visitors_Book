class PlacesController < ApplicationController
  before_action :set_place, only: [:show, :edit, :update, :destroy]

  def index
    @places = Place.all.includes(:subcategory, :city).order('id DESC')
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
    unless Rate.all.where(dimension: "advice").empty?
      advice = Rate.all.where(dimension: "advice")
      total = 0.0
      advice.each {|a| total += a.stars}
      @a_r = total/advice.count
    end

    unless Rate.all.where(dimension: "service").empty?
      service = Rate.all.where(dimension: "service")
      total = 0.0
      service.each {|a| total += a.stars}
      @s_r = total/service.count
    end

    unless Rate.all.where(dimension: "taste").empty?
      taste = Rate.all.where(dimension: "taste")
      total = 0.0
      taste.each {|a| total += a.stars}
      @t_r = total/taste.count
    end

    unless Rate.all.where(dimension: "fun").empty?
      fun = Rate.all.where(dimension: "fun")
      total = 0.0
      fun.each {|a| total += a.stars}
      @f_r = total/fun.count
    end
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
