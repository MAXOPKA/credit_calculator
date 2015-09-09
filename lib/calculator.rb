class Calculator

  TYPES = %w{standart annuitet}

  attr_reader :result

  def initialize params
    @percent = params[:percent].to_f
    @summ = params[:summ].to_f
    @months = params[:months].to_i
    @type = params[:type] if self::TYPES.include(params[:type])
  end

  def calculate
    prepare_result
  end

  private

  def prepare_result
    @result = []
    [1..@months].each do |month|
      @result << {
        month_num: month,
        credit_repayment: 1234,
        percent_repayment: 1234,
        common_payment: 1213,
        credit_balance: 1234
      }
    end
  end

end
