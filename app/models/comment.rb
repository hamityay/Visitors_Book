class Comment < ActiveRecord::Base

  belongs_to :commentable, polymorphic: true, counter_cache: :commentable_count
end
