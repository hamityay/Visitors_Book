class Hq::CategoriesController < Hq::ApplicationController

  before_action :set_category, only: [:show, :edit, :update, :destroy]
  add_breadcrumb I18n.t('activerecord.models.categories'), :hq_categories_path

  def index
    @search = Category.order(id: :desc).search(params[:q])
    @categories = @search.result(distinct: true).paginate(page: params[:page])
    respond_with(@categories)
  end

  def show
    add_breadcrumb @category.name, hq_category_path(@category)
    respond_with(@category)
  end

  def new
    add_breadcrumb t('tooltips.new'), new_hq_category_path
    @category = Category.new
    respond_with(@category)
  end

  def edit
    add_breadcrumb @category.name, hq_category_path(@category)
    add_breadcrumb t('tooltips.edit'), edit_hq_category_path
  end

  def create
    @category = Category.new(category_params)
    @category.save
    respond_with(:hq, @category)
  end

  def update
    @category.update(category_params)
    respond_with(:hq, @category)
  end

  def destroy
    @category.destroy
    respond_with(:hq, @category, location: request.referer)
  end

  private

  def category_params
    params.require(:category).permit(:name)
  end

  def set_category
    @category = Category.find(params[:id])
  end

end
