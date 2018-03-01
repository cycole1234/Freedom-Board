require 'sinatra'
require 'yaml/store'

get '/' do
  erb :index
end
post '/' do
	@message = params['txt1']
	@user = params['txt2']
	@time = Time.now.strftime("%d/%m/%Y %H:%M:%S")
	
	@store = YAML::Store.new 'message.yml'
	@store.transaction do
		if @user == ''
			@store[@time] = [@message, 'Anonymous']
		else
			@store[@time] = [@message, @user]
		end
	end
	erb :index
end

