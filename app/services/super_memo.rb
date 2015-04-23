class SuperMemo

  def initialize(result, answer_time, parameters)
    @check_result = result
    @answer_time = answer_time
    parameters = OpenStruct.new(parameters) if parameters.is_a?(Hash)
    unless %i(attempts efactor interval).to_set.subset?(parameters.methods.to_set)
      raise ArgumentError, "Ошибка в аргументах"
    end
    @efactor = parameters.efactor
    @interval = parameters.interval
    @attempts = parameters.attempts
    @quality = set_quality
  end

  def call
    if @quality < 3
      @attempts = 0
      @interval = 0
      @efactor = 2.5
      @review_date = Time.now
    else
      @attempts += 1
      @interval = get_interval
      @review_date = Time.now + @interval.days
    end
    {
      efactor: @efactor,
      attempts: @attempts,
      interval: @interval,
      review_date: @review_date
    }
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

  def get_interval
    case @attempts
    when 1 then 1
    when 2 then 6
    else (@interval * get_efactor).round
    end
  end
end
