class CheckAnswer

  def initialize(card, answer)
    @card = card
    @answer = answer
  end

  def call
    if @answer
      @card.attempts = 0
      set_interval(@card.repetition_number)
    else
      if @card.attempts < 3
        @card.attempts += 1
      else
        @card.attempts = 0
        set_interval(0)
      end
    end
    @card.save
    @answer
  end

  private

  def set_interval(repetition_number)
    @card.repetition_number = repetition_number + 1
    @card.review_date = Time.now +
      NextInterval.get_interval(@card.repetition_number)
  end
end
