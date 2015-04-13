class Card < ActiveRecord::Base
  belongs_to :pack

  validates :original_text, :translated_text, :review_date, presence: true
  validates :pack, presence: true
  validate :translated_text_not_equal_original
  validates :attempts, numericality: { only_integer: true },
            inclusion: { in: 0..3 }
  validates :repetition_number, numericality: { only_integer: true }

  before_validation :set_review_date, on: :create

  scope :active, -> { where("review_date <= ?", Time.now).order("RANDOM()") }
  mount_uploader :image, ImageUploader

  def check_translation(answer)
    CheckAnswer.new(
      self,
      original_text.mb_chars.downcase.to_s == answer.mb_chars.downcase.to_s
    ).call
  end

  private

  def set_review_date
    self.review_date = Time.now
  end

  def translated_text_not_equal_original
    if original_text.mb_chars.downcase.to_s == translated_text.mb_chars.downcase.to_s
      errors[:translated_text] << "Must not be equal original text"
    end
  end
end
