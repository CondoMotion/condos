class Company < ActiveRecord::Base
  attr_accessible :address, :city, :name, :phone, :state, :zip

  belongs_to :owner, :class_name => "User"
  has_many :sites
  has_many :users

  validates_presence_of :name
end
