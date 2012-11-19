class Site < ActiveRecord::Base
  belongs_to :company
  has_many :posts
  attr_accessible :address, :city, :description, :name, :state, :subdomain, :zip

  validates_presence_of :name, :subdomain
  validates_uniqueness_of :subdomain
end
