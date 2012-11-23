class Company < ActiveRecord::Base
	after_create :add_owner_to_company
  attr_accessible :address, :city, :name, :phone, :state, :zip

  belongs_to :owner, :class_name => "User"
  has_many :sites
  has_many :users
  has_many :roles

  before_create :add_default_roles

  validates_presence_of :name

private
	def add_owner_to_company
		@owner = self.owner
		@owner.company_id = self.id
		@owner.manager = 1 
		@owner.save
	end

	def add_default_roles
		@role = self.roles.new(name: "Resident", permission: 1)
		@role.save

		@role = self.roles.new(name: "Admin", permission: 2)
		@role.save

		@role = self.roles.new(name: "Trustee", permission: 3)
		@role.save

		@role = self.roles.new(name: "Manager", permission: 4)
		@role.save
	end

end
