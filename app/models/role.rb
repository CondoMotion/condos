class Role < ActiveRecord::Base
  belongs_to :company
  attr_accessible :name, :permission
  default_scope order('permission DESC')
end
