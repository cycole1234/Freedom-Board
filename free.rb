require 'sinatra'
require 'yaml/store'

get '/' do
	if File.exist? "message.yml"
		@yaml_file = YAML.load(File.read("message.yml"))
	end
    erb :index
end

post '/' do
	@message = params['txt1']
	@user = params['txt2']
	@time = Time.now.strftime("%d/%m/%Y %H:%M:%S")
	
	@store = YAML::Store.new 'message.yml'
	@store.transaction do
		if @user == ''
			@store[@time] = [@message, 'Walang lagda']
		else
			@store[@time] = [@message, @user]
		end
	end
	@yaml_file = YAML.load(File.read("message.yml"))
	erb :index
end
post '/findpost' do
	@findpost = params['txt3']
	@store1= Hash.new
	@yaml_file = YAML.load(File.read("message.yml"))
	@yaml_file.each do |key, value|
		if value[1] =~ Regexp.new(@findpost) || value[0] =~ Regexp.new(@findpost)
			@store1[key] =value
		end
	end
	@yaml_file=@store1
	erb :index
end
post '/allposts' do
	@yaml_file = YAML.load(File.read("message.yml"))
	erb :index
end

