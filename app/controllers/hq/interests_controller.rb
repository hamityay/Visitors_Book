class InterestsController < ApplicationController

  before_action :set_interest, only: [:show, :edit, :update, :destroy]
  add_breadcrumb I18n.t('activerecord.models.interests'), :hq_interests_path

  def index
    @search = Interst.order(id: :desc).search(params[:q])
    @interests = @search.result(distinct: true).paginate(page: params[:page])
    respond_with(@interests)
  end

  def show
    add_breadcrumb @country.name, hq_interest_path(@interest)
    respond_with(@interest)
  end

  def new
    add_breadcrumb t('tooltips.new'), new_hq_interest_path
    @interest = Interst.new
    respond_with(@interest)
  end

  def edit
    add_breadcrumb @interest.name, hq_interest_path(@interest)
    add_breadcrumb t('tooltips.edit'), edit_hq_interest_path
  end

  def create
    @interest = Interst.new(interest_params)
    @interest.save
    respond_with(:hq, @interest)
  end

  def update
    @interest.update(interest_params)
    respond_with(:hq, @interest)
  end

  def destroy
    @interest.destroy
    respond_with(:hq, @interest, location: request.referer)
  end

  private

  def interest_params
    params.require(:interest).permit(:name)
  end

  def set_interest
    @interest = Interst.find(params[:id])
  end

end
