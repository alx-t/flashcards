class TranslatedTextValidator < ActiveModel::Validator
  def validate(record)
    if record.original_text.downcase == record.translated_text.downcase
      record.errors[:translated_text] << "Must not be equal original text"
    end
  end
end

class Card < ActiveRecord::Base
  validates :original_text, :translated_text, :review_date, presence: true
  validates_with TranslatedTextValidator

  before_validation :set_review_date

  protected

    def set_review_date
      self.review_date = Time.now + 3.days
    end
end
