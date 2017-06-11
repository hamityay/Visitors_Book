class PlacesController < ApplicationController
  before_action :set_place, only: [:show, :edit, :update, :destroy]
  before_action :authorize_user!, only: [:edit, :update, :destroy]

  def index
    @places = Place.all.includes(:subcategory, :city).where(:is_active => true).order('id DESC')
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
    unless @place.rates.nil?
      unless Rate.all.where( :rateable_id => @place.id, :dimension => "advice").nil?
        advice = Rate.all.where(:rateable_id => @place.id, :dimension => "advice")
        total = 0.0
        advice.each {|a| total += a.stars}
        @a_r = total/advice.count
      end

      unless Rate.all.where(:dimension => "service", :rateable_id => @place.id).nil?
        service = Rate.all.where(:dimension => "service", :rateable_id => @place.id)
        total = 0.0
        service.each {|a| total += a.stars}
        @s_r = total/service.count
      end

      unless Rate.all.where(:dimension => "taste", :rateable_id => @place.id).nil?
        taste = Rate.all.where(:dimension => "taste", :rateable_id => @place.id)
        total = 0.0
        taste.each {|a| total += a.stars}
        @t_r = total/taste.count
      end

      unless Rate.all.where(:dimension => "fun", :rateable_id => @place.id).nil?
        fun = Rate.all.where(:dimension => "fun", :rateable_id => @place.id)
        total = 0.0
        fun.each {|a| total += a.stars}
        @f_r = total/fun.count
      end
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

  def search
    if params[:search]
      s = params[:search].downcase
      if s
        @s_places = Place.all.where('lower(name) LIKE ?', "%#{s}%")
        redirect_to search_path
      else
        redirect_to places_path
      end
    end
  end

  private
    def place_params
      params.require(:place).permit(:name, :address, :description, :phone, :email,
                                    :subcategory_id, :country_id, :city_id)
    end

    def set_place
      @place = Place.find(params[:id])
    end

    def authorize_user!
      redirect_to root_path, alert: "Buna Yetkiniz Yok."
    end
end
