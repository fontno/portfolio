class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :token_authenticatable

  # callbacks
  #
  # TODO before save will fire on updates also
  # before_save :ensure_authentication_token!
  before_create :ensure_authentication_token!

  # associations
  has_many :posts
  has_many :relationships, foreign_key: "follower_id", dependent: :destroy
  has_many :followeds, through: :relationships
  has_many :reverse_relationships, foreign_key: "followed_id", class_name: "Relationship", dependent: :destroy
  has_many :followers, through: :reverse_relationships

  # TODO the string without table name throws ambiguous column name error
  default_scope -> { order 'users.created_at DESC' }

  def feed
    posts
  end

  def following?(other_user)
    relationships.find_by(followed_id: other_user.id)
  end

  def follow!(other_user)
    relationships.create!(followed_id: other_user.id)
  end

  def unfollow!(other_user)
    relationships.find_by(followed_id: other_user.id).destroy!
  end

  def authentication_token_expired?
    # TODO stubbed
    self.authentication_token.blank?
  end
end
