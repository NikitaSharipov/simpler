Simpler.application.routes do

  post '/tests', 'tests#create'
  get '/tests/:id', 'tests#show'
  get '/tests', 'tests#index'

end
