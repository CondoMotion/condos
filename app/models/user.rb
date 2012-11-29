class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :owned_company_attributes, :fullname, :manager
  # attr_accessible :title, :body

  has_one :owned_company, :class_name => "Company", :foreign_key => "owner_id"
  belongs_to :company
  has_many :memberships
  has_many :sites, :through => :memberships
  has_many :documents
  has_many :photos
  has_many :news
  has_many :posts

  accepts_nested_attributes_for :owned_company

  def site_role(site)
    if Membership.where(:user_id => self.id).where(:site_id => site.id).first().nil?
      Role.new(:permission_id => 0, :name => "guest")
    else
      Membership.where(:user_id => self.id).where(:site_id => site.id).first().role
    end
  end

end
