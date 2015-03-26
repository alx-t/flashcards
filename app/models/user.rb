class User < ActiveRecord::Base
  has_many :cards, dependent: :destroy

  validates :email, presence: true, format: { with: /.+@.+\..+/i }
  validates :password, presence: true, length: { minimum: 6 }
end
