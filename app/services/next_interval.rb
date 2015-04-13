class NextInterval
  REVIEW_INTERVAL = { 1 => 12.hours,
                      2 => 3.days,
                      3 => 1.week,
                      4 => 2.weeks,
                      5 => 1.month
  }

  def self.get_interval(repetition_number)
    repetition_number = 5 if repetition_number > 5
    repetition_number = 1 if repetition_number < 1
    REVIEW_INTERVAL[repetition_number]
  end
end
