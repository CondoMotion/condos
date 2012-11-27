class Photo < ActiveRecord::Base
  belongs_to :site
  belongs_to :user
  attr_accessible :attachment, :permission, :title
  mount_uploader :attachment, AttachmentUploader
end
