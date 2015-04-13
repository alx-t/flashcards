class CheckAnswer < Struct.new(:card, :check_result)
  REVIEW_INTERVAL = { 1 => 12.hours,
                      2 => 3.days,
                      3 => 1.week,
                      4 => 2.weeks,
                      5 => 1.month
  }

  def call
    if check_result
      card.attempts = 0
      set_interval(card.repetition_number)
    else
      if card.attempts < 3
        card.attempts += 1
      else
        card.attempts = 0
        set_interval(0)
      end
    end
    card.save
    check_result
  end

  private

  def set_interval(repetition_number)
    card.repetition_number = repetition_number + 1
    card.review_date = Time.now + get_interval(card.repetition_number)
  end

  def get_interval(repetition_number)
    repetition_number = 5 if repetition_number > 5
    repetition_number = 1 if repetition_number < 1
    REVIEW_INTERVAL[repetition_number]
  end
end
