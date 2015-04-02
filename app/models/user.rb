class User < ActiveRecord::Base
  authenticates_with_sorcery! do |config|
    config.authentications_class = Authentication
  end

  has_many :cards
  has_many :packs, dependent: :destroy
  belongs_to :current_pack, class_name: "Pack"
  has_many :authentications, dependent: :destroy  
  accepts_nested_attributes_for :authentications

  validates :email, presence: true, uniqueness: { case_sensitive: false }, 
            format: { with: /.+@.+\..+/i }
  validates :password, presence: true, length: { minimum: 6 }
  validates :password, confirmation: true
  validates :password_confirmation, presence: true

  def card_for_review
    if current_pack
      current_pack.cards.active.first
    else
      cards.active.first
    end
  end
end
