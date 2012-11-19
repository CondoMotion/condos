class Post < ActiveRecord::Base
  belongs_to :site
  attr_accessible :content, :title, :site_id, :permission_id, :post_type, :attachment, :remote_attachment_url
  mount_uploader :attachment, AttachmentUploader

  POST_TYPES = %w[news documents photos]

  def post_type_symbols
    [post_type.to_sym]
  end

end
