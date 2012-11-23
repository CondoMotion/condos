class Company < ActiveRecord::Base
	after_create :add_owner_to_company
  attr_accessible :address, :city, :name, :phone, :state, :zip

  belongs_to :owner, :class_name => "User"
  has_many :sites
  has_many :users
  has_many :roles

  validates_presence_of :name

private
	def add_owner_to_company
		@owner = self.owner
		@owner.company_id = self.id
		@owner.manager = 1 
		@owner.save
	end

end
