class User < ActiveRecord::Base
  authenticates_with_sorcery! do |config|
    config.authentications_class = Authentication
  end

  has_many :packs, dependent: :destroy
  belongs_to :current_pack, class_name: "Pack"
  has_many :authentications, dependent: :destroy
  accepts_nested_attributes_for :authentications

  validates :email, presence: true, uniqueness: { case_sensitive: false }
  validates :password, confirmation: true
  validates :password, presence: true, if: :new_record?
  validates :password, length: { minimum: 6 }, allow_blank: true

  def card_for_review
    if current_pack
      current_pack.cards.active.first
    else
      get_active_cards
    end
  end

  private

    def get_active_card
      active_cards = []
      packs.each do |pack|
        active_cards << pack.cards.active
      end
      active_cards.sample
    end
end
