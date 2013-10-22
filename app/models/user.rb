class User < ActiveRecord::Base
  has_many :posts

  default_scope -> { order 'created_at DESC' }

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  def feed
    posts
  end
end
