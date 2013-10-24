get '/' do
  @user = User.find_by_id(session[:user_id])
  erb :index
end

get '/login' do
  erb :login
end


post '/login' do
  @user = User.authenticate(params[:email], params[:password])
  if @user
    session[:user_id] = @user.id
    redirect '/events'
  else
    @login_error = "Invalid email or password."
    erb :login
  end
end

get '/logout' do
  session.clear
  redirect '/'
end

get '/create_user' do
  erb :create_user
end

post '/create_user' do
  @user = User.new(email: params[:email], password: params[:password], password_confirmation: params[:password_confirmation])
  if @user.save
    session[:user_id] = @user.id
    redirect '/events'
  else
    @create_user_error = "Invalid email or password."
    erb :create_user
  end
end
