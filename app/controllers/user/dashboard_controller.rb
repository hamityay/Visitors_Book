class User::DashboardController < User::UserApplicationController

  add_breadcrumb I18n.t('dock.dashboard'), :user_dashboard_index_path

  def index
    @last_plc = Place.all.where(is_active: true).order('created_at DESC').limit(5)
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

end