class SuperMemo

  def initialize(card, check_result, answer_time)
    @card = card
    @check_result = check_result
    @answer_time = answer_time
    @quality = set_quality
    @efactor = @card.efactor
  end

  def call
    if @quality < 3
      @card.attempts = 0
      @card.interval = 0
      @card.efactor = 2.5
    else
      @card.attempts += 1
      @card.interval = get_interval(@card.attempts)
      @card.efactor = @efactor
      @card.review_date = Time.now + @card.interval.days
    end
    @card.save
  end

  private

  def set_quality
    if @check_result
      case @answer_time
      when 0..5
        @quality = 5
      when 6..10
        @quality = 4
      else
        @quality = 3
      end
    else
      @quality = 0
    end
    @quality
  end

  def get_efactor
    @efactor += (0.1 - (5 - @quality) * (0.08 + (5 - @quality) * 0.02))
    @efactor = 1.3 if @efactor < 1.3
    @efactor = 2.5 if @efactor > 2.5
    @efactor
  end

  def get_interval(attempts)
    case attempts
    when 1 then 1
    when 2 then 6
    else (@card.interval * get_efactor).round
    end
  end
end
