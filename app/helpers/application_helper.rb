module ApplicationHelper

  def get_locales
    I18n.available_locales.map { |l| [I18n.t(l), l.to_s] }
  end
end
