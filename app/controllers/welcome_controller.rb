class WelcomeController < ApplicationController
  def index
    plc = Place.last
    @slider = []
    @slider.push(plc.images.last)
    @slider.push(plc.images.first)
    @slider.push(plc.images.fourth)
    @slider.push(plc.images.fifth)
    @slider.push(plc.images.second)
    @last_plc = Place.all.where(is_active: true).order('created_at DESC').limit(5)
    @com_plc = Place.all.where(is_active: true).order('commentable_count ASC').limit(5)
    @sub_plc = Place.includes(:subcategory).where(is_active: true).joins(:subcategory).merge(Subcategory.order(created_at: :desc)).limit(5)
    @cat = Category.includes(:subcategories).all.order(name: :desc)
    l_com = Comment.all.where(commentable_type: "Place").order('created_at DESC')
    @l_com_plc = []
    c = 0
    l_com.each do |p|
      pl = Place.find(p.commentable_id)
      if pl.is_active == true
        unless @l_com_plc.include?(pl)
          @l_com_plc << pl
          c += 1
        end
      end
      if c == 5
        break
      end
    end
  end

  def search

  end
end