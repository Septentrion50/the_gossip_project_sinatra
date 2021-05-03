require 'gossip'

# a controller
class ApplicationController < Sinatra::Base
  get '/' do
    erb:index, locals: { gossips: Gossip.all }
  end

  get '/gossips/new/' do
    erb:new_gossip
  end

  post '/gossips/new/' do
    Gossip.new(params['gossip_author'], params['gossip_content']).save
    redirect '/'
  end

  get '/gossips/:id/' do
    erb:show, locals: { id: params['id'], to_disp: Gossip.find(params['id']), comm: Gossip.find_comm(params['id']) }
  end

  get '/gossips/:id/comment/' do
    erb:comment, locals: { id: params['id'] }
  end

  post '/gossips/:id/comment/' do
    erb:comment, locals: { id: params['id'], comm: Gossip.comment(params['id'], params['comm']) }
    redirect '/'
  end

  get '/gossips/:id/edit/' do
    erb:edit, locals: { id: params['id'] }
  end

  post '/gossips/:id/edit/' do
    erb:edit, locals: { id: params['id'], to_edit: Gossip.update(params['id'], params['gossip_author'], params['gossip_content']) }
    redirect '/'
  end
end
