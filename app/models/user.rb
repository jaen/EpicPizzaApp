class User < ActiveRecord::Base
  has_many :orders

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
#         :confirmable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :username, :email, :password, :password_confirmation, :remember_me
  # attr_accessible :title, :body

  as_enum :type, [:user, :admin]

  def has_open_order?
    false
  end

  def admin?
    type == :admin
  end

  def user?
    type == :user
  end 
end
