class Pack < ActiveRecord::Base
  belongs_to :user
  has_many :cards, dependent: :destroy
  attr_accessor :current
  validates :title, :user, presence: true

  def current=(new_value)    
    return unless user
    case new_value
    when "1"
      set_current
    when "0"
      reset_current
    end
  end

  def current
    user.current_pack == self
  end

  private
    def set_current
      user.update_attribute(:current_pack, self)
    end

    def reset_current
      user.update_attribute(:current_pack, nil)
    end
end
