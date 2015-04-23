class Card < ActiveRecord::Base
  belongs_to :pack

  validates :original_text, :translated_text, :review_date, presence: true
  validates :pack, presence: true
  validates :interval, :attempts, numericality: { only_integer: true }
  validates :efactor, numericality: { greater_than_or_equal_to: 1.3,
                                      less_than_or_equal_to: 2.5 }
  validate :translated_text_not_equal_original

  before_validation :set_review_date, on: :create

  scope :active, -> { where("review_date <= ?", Time.now) }
  scope :random, -> { order("RANDOM()") }
  mount_uploader :image, ImageUploader

  def check_translation(answer, answer_time)
    result = DamerauLevenshtein.distance(
      original_text.mb_chars.downcase.to_s,
      answer.mb_chars.downcase.to_s
    )
    result_status = result <= 1
    card_params = SuperMemo.new(result_status, answer_time, self).call
    update_attributes(card_params)
    { success: result_status, typos_count: result }
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
