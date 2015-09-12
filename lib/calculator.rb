class Calculator

  attr_reader :result

  def initialize params = {}
    @i = (params[:percent].to_f / 100) / 12
    @summ = params[:summ].to_f
    @months = params[:months].to_i
    @type = params[:type]
    @result = { rows: [], total: { summ: @summ, percent_summ: 0, total_summ: @summ } }
  end

  def calculate
    if @type == 'annuitet'
      calculate_annuitet
    else
      calculate_standard
    end
    @result[:total][:total_summ] = @result[:total][:total_summ] + @result[:total][:percent_summ]
    self
  end

  private

  def calculate_annuitet
    @month_payment = @summ * (@i + @i/(((1 + @i)**@months) - 1))
    (1..@months).each do |month|
      @result[:total][:percent_summ] += @percent_part = @summ * @i
      @payment_part = @month_payment - @percent_part
      @summ -= @payment_part
      @result[:rows] << result_row
    end
  end

  def calculate_standard
    @payment_part = @summ / @months
    (1..@months).each do |month|
      @result[:total][:percent_summ] += @percent_part = @summ * @i
      @summ -= @payment_part
      @month_payment = @payment_part + @percent_part
      @result[:rows] << result_row
    end
  end

  def result_row
    {
      credit_repayment: @payment_part.round(2),
      percent_repayment: @percent_part.round(2),
      common_payment: @month_payment.round(2),
      credit_balance: @summ.round(2)
    }
  end
end
