class Site < ActiveRecord::Base
  belongs_to :company

  belongs_to :fields, polymorphic: true

  has_many :posts
  has_many :documents
  has_many :photos
  has_many :news
  has_many :memberships
  has_many :users, :through => :memberships
  attr_accessible :address, :city, :description, :name, :state, :subdomain, :zip, :layout_name, :user_ids

	default_scope { where(company_id: Company.current_id) }
  
  validates_presence_of :name, :subdomain
  validates_uniqueness_of :subdomain

end