class Post < ActiveRecord::Base
	belongs_to :site
	belongs_to :user
	belongs_to :fields, polymorphic: true
end