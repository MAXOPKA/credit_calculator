
require 'sinatra'
require 'slim'
require 'lib/*'

set :views, settings.root + '/views'

get '/' do
  @header = 'Калькулятор'
  slim :form
end

post '/result' do
  @header = 'Результат'
  @resul = Calculator.new.calculate params[:calculator]
  slim :result
end
