class Hq::PlacesController < Hq::ApplicationController

  before_action :set_place, only: [:show, :edit, :update, :destroy, :toggle_is_active]
  add_breadcrumb I18n.t('activerecord.models.places'), :hq_places_path

  def index
    @search = Place.order(id: :desc).search(params[:q])
    @places = @search.result(distinct: true).paginate(page: params[:page])
    respond_with(@places)
  end

  def show
    add_breadcrumb @place.name, hq_place_path(@place)
    respond_with(@place)
  end

  def new
    add_breadcrumb t('tooltips.new'), new_hq_place_path
    @place = Place.new
    respond_with(@place)
  end

  def edit
    add_breadcrumb @place.name, hq_place_path(@place)
    add_breadcrumb t('tooltips.edit'), edit_hq_place_path
  end

  def create
    @place = Place.new(place_params)
    @place.save
    respond_with(:hq, @place)
  end

  def update
    @place.update(place_params)
    respond_with(:hq, @place)
  end

  def destroy
    @place.destroy
    respond_with(:hq, @place, location: request.referer)
  end

  def toggle_is_active
    if @place.update( is_active: !@place.is_active )
      @place.is_active ?
        flash[:info] = t('flash.actions.toggle_is_active.active', resource_name: Place.model_name.human) :
        flash[:info] = t('flash.actions.toggle_is_active.passive', resource_name: Place.model_name.human)
    else
      flash[:danger] = t('flash.messages.error_occurred')
    end
    respond_with(:hq, @place, location: request.referer)
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
