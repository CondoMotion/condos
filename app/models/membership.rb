class Membership < ActiveRecord::Base
  belongs_to :site
  belongs_to :user
  attr_accessible :role, :site_id

  before_create :set_role

  ROLES = %w[manager trustee admin resident]

  def role_symbols
    [post_type.to_sym]
  end

private
	def set_role
		if self.user.manager?
			self.role ||= "manager"
		else
			self.role ||= "resident"
		end
	end
end
