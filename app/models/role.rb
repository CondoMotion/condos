class Role < ActiveRecord::Base
  belongs_to :company
  attr_accessible :name, :permission
end
