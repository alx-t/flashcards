class User < ActiveRecord::Base
  authenticates_with_sorcery! do |config|
    config.authentications_class = Authentication
  end

  has_many :cards, dependent: :destroy
  has_many :authentications, dependent: :destroy
  accepts_nested_attributes_for :authentications

  validates :email, presence: true, uniqueness: { case_sensitive: false }, 
            format: { with: /.+@.+\..+/i }
  validates :password, presence: true, length: { minimum: 6 }
  validates :password, confirmation: true
  validates :password_confirmation, presence: true
end
