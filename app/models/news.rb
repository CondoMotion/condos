class News < ActiveRecord::Base
  belongs_to :site
  belongs_to :user
  has_one :post, as: :fields, dependent: :destroy
  attr_accessible :content, :permission, :title
end
