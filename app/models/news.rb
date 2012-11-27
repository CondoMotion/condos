class News < ActiveRecord::Base
  belongs_to :site
  belongs_to :user
  attr_accessible :content, :permission, :title
end
