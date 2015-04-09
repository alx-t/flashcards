class User < ActiveRecord::Base
  authenticates_with_sorcery! do |config|
    config.authentications_class = Authentication
  end

  has_many :packs, dependent: :destroy
  has_many :cards, through: :packs
  belongs_to :current_pack, class_name: "Pack"
  has_many :authentications, dependent: :destroy
  accepts_nested_attributes_for :authentications

  validates :email, presence: true, uniqueness: { case_sensitive: false }
  validates :password, confirmation: true
  validates :password, presence: true, if: :new_record?
  validates :password, length: { minimum: 6 }, allow_blank: true
  validate :current_pack_belongs_to_user

  def card_for_review
    if current_pack
      current_pack.cards.active.first
    else
      cards.active.first
    end
  end

  private

  def current_pack_belongs_to_user
    unless self.current_pack.nil? || self.packs.include?(self.current_pack)
      errors[:pack_not_belongs_to_user] << "Current pack must belongs to user"
    end
  end
end
