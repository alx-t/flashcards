class Pack < ActiveRecord::Base
  belongs_to :user
  has_many :cards, dependent: :destroy
  validates :title, :user, presence: true

  def current?
    user.current_pack == self
  end
end
