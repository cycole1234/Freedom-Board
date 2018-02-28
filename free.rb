require 'sinatra'
require 'yaml/store'

get '/' do
  erb :index
end
post '/' do
	@message = params['txt1']
	@user = params['txt2']
	
	UserPost = Struct.new :message
	
	@store = YAML::Store.new 'message.yml'
	@store.transaction do
		if @user == ''
			@store['Anonymous'] = @message
		else
			@store[@user] = @message
		end
	end
	erb :index
end

