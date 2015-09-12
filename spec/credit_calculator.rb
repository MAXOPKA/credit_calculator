ENV['RACK_ENV'] = 'test'

require File.expand_path '../../credit_calculator.rb', __FILE__

require 'rspec'
require 'rack/test'

describe 'Credit calculator app' do
  include Rack::Test::Methods

  def app() Sinatra::Application end

  describe do 'app responses'
    it 'render root' do
      get '/'
      expect(last_response.body).to include 'Калькулятор'
    end

    it 'render result' do
      post '/result', { calculator: { percent: '12.1', summ: '1000000', type: 'annuitet', months: '60' } }
      expect(last_response.body).to include 'Результат'
    end
  end

  describe 'Calculator' do
    data = { percent: '12.1', months: '60', summ: '1000000' }

    it 'Annuitet' do
      first_row = [ 12211.69, 10083.33, 22295.02, 987788.31 ]
      last_row = [ 22072.46, 222.56, 22295.02, 0.00 ]
      total_row = [ 1000000.00, 337700.72, 1337700.72 ]
      data[:type] = 'annuitet'
      result = Calculator.new(data).calculate.result
      first_row.each_with_index{ |value, i| expect(value.round).to be result[:rows][0].to_a[i][1].round }
      last_row.each_with_index{ |value, i| expect(value.round).to be result[:rows][-1].to_a[i][1].round }
      total_row.each_with_index{ |value, i| expect(value.round).to be result[:total].to_a[i][1].round }
    end

    it 'Standard' do
      first_row = [ 16666.67, 10083.33, 26750.00, 983333.33 ]
      last_row = [ 16666.67, 168.06,  16834.73, 0.00 ]
      total_row = [ 1000000.00, 307541.67, 1307541.67 ]
      data[:type] = 'standard'
      result = Calculator.new(data).calculate.result
      first_row.each_with_index{ |value, i| expect(value.round).to be result[:rows][0].to_a[i][1].round }
      last_row.each_with_index{ |value, i| expect(value.round).to be result[:rows][-1].to_a[i][1].round }
      total_row.each_with_index{ |value, i| expect(value.round).to be result[:total].to_a[i][1].round }
    end
  end
end

def get_data
end
