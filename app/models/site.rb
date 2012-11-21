class Site < ActiveRecord::Base
  belongs_to :company
  has_many :posts  
  has_many :memberships
  has_many :users, :through => :memberships
  attr_accessible :address, :city, :description, :name, :state, :subdomain, :zip, :layout_name, :user_ids

  validates_presence_of :name, :subdomain
  validates_uniqueness_of :subdomain
end