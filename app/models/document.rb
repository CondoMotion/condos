class Document < ActiveRecord::Base
  belongs_to :site
  belongs_to :user
  has_one :post, as: :fields, dependent: :destroy
  attr_accessible :attachment, :permission, :title
  mount_uploader :attachment, AttachmentUploader
end
