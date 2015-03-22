class Card < ActiveRecord::Base
  validates :original_text, :translated_text, :review_date, presence: true
  validate :translated_text_not_equal_original
  before_validation :set_review_date, on: :create

  protected

    def set_review_date
      self.review_date = Time.now + 3.days
    end

    def translated_text_not_equal_original
      if original_text.downcase == translated_text.downcase
        errors[:translated_text] << "Must not be equal original text"
      end
    end
end
