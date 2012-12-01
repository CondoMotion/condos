class Company < ActiveRecord::Base
	after_create :add_owner_to_company
  attr_accessible :address, :city, :name, :phone, :state, :zip

  belongs_to :owner, :class_name => "User"
  has_many :sites
  has_many :users
  has_many :roles
  has_many :posts, through: :sites

  before_create :add_default_roles

  validates_presence_of :name

  def self.current_id=(id)
    Thread.current[:company_id] = id
  end
  
  def self.current_id
    Thread.current[:company_id]
  end

private
	def add_owner_to_company
		@owner = self.owner
		@owner.company_id = self.id
		@owner.manager = 1 
		@owner.save
	end

	def add_default_roles
		@role = self.roles.create(name: "Resident", permission: 1)
		@role = self.roles.create(name: "Admin", permission: 2)
		@role = self.roles.create(name: "Trustee", permission: 3)
		@role = self.roles.create(name: "Manager", permission: 4)	
	end

end
