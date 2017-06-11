class CategoriesController < ApplicationController

  def index
    @categories = Category.all.includes(:places)
  end

end