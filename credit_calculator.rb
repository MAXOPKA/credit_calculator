
require 'sinatra'
require 'slim'

Dir[settings.root + '/lib/*.rb'].each {|file| require file }

set :views, settings.root + '/views'

get '/' do
  @header = 'Калькулятор'
  slim :form
end

post '/result' do
  @header = 'Результат'
  @result = Calculator.new(params[:calculator]).calculate.result
  slim :result
end
