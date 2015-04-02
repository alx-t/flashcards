class Card < ActiveRecord::Base
  belongs_to :user
  belongs_to :pack

  validates :original_text, :translated_text, :review_date, presence: true
  validates :user, presence: true
  validates :pack, presence: true
  validate :translated_text_not_equal_original
  
  before_validation :set_review_date, on: :create
  before_validation :set_user, on: :create

  scope :active, -> { where("review_date <= ?", Time.now).order("RANDOM()") }
  mount_uploader :image, ImageUploader

  def check_translation(answer)
    if original_text.mb_chars.downcase.to_s == answer.mb_chars.downcase.to_s
      set_review_date
      save
      return true
    else
      return false
    end
  end

  private
  
    def set_review_date
      self.review_date = Time.now + 3.days
    end

    def set_user
      self.user ||= pack.user
    end

    def translated_text_not_equal_original
      if original_text.downcase == translated_text.downcase
        errors[:translated_text] << "Must not be equal original text"
      end
    end
end
