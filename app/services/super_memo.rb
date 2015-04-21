class SuperMemo

  def initialize(card, check_result, answer_time)
    @card = card
    @check_result = check_result
    @answer_time = answer_time
    @quality = set_quality
    @efactor = @card.efactor
    @interval = @card.interval
    @attempts = @card.attempts
    @review_date = @card.review_date
  end

  def call
    if @quality < 3
      @attempts = 0
      @interval = 0
      @efactor = 2.5
    else
      @attempts += 1
      @interval = get_interval(@attempts)
      @review_date = Time.now + @interval.days
    end
    save_card
  end

  private

  def save_card
    @card.attempts = @attempts
    @card.interval = @interval
    @card.efactor = @efactor
    @card.review_date = @review_date
    @card.save
  end

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
    else (@interval * get_efactor).round
    end
  end
end
