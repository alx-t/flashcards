class Pack < ActiveRecord::Base
  belongs_to :user
  has_many :cards, dependent: :destroy
  attr_accessor :current
  validates :title, :user, presence: true

  def current=(value)
    return unless user
    if value
      set_current
    else
      reset_current
    end
  end

  def current?
    user.current_pack == self
  end

  private

  def set_current
    user.update_attributes(current_pack: self)
  end

  def reset_current
    user.update_attributes(current_pack: nil)
  end
end
