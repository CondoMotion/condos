class Site < ActiveRecord::Base
  belongs_to :company
  has_many :posts  
  has_many :memberships
  has_many :users, :through => :memberships
  attr_accessible :address, :city, :description, :name, :state, :subdomain, :zip, :layout_name, :user_ids, :temp_pw

  validates_presence_of :name, :subdomain
  validates_uniqueness_of :subdomain
  validates_length_of :temp_pw, :minimum => 6
end