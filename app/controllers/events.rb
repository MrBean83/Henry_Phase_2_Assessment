get '/events' do
  unless current_user
    redirect '/'
  end

  @created_events = current_user.created_events
  erb :show_events
end

get '/events/create' do
  erb :create_event
end

post '/events/create' do
  @event = Event.new params[:event]
  @event.user_id = current_user.id

  if @event.save
    redirect '/events'
  else
    @event_create_error = "Something's wrong on your end...you can't create an event right now."
    erb :create_event
  end
end

post '/events/create/ajax' do
  @event = Event.new(params)
  @event.user_id = current_user.id
  @event.save
  response = "#{@event.name}, #{@event.location}, #{format_date(@event.starts_at)}, #{format_date(@event.ends_at)}"
end

post '/events/delete' do
  @event = Event.find(params[:event_id])
  @event.destroy
  redirect '/events'
end

get '/events/edit' do
  @event = Event.find(params[:event_id])
  erb :edit_event
end

post '/events/edit' do
  @event = Event.find(params[:event_id])
  @event.update_attributes(params[:event])
  redirect '/events'
end
