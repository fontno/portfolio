class Post < ActiveRecord::Base
  belongs_to :user

  mount_uploader :image, ImageUploader

  validates :text, presence: true
  validates :user_id, presence: true
end
