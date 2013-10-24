helpers do

  def current_user
    @user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def format_date(date)
    date.strftime("%b %d, %Y %H:%m %p")
  end

end
