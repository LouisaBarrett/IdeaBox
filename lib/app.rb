require 'bundler'
Bundler.require
require_relative 'idea_box'

class IdeaBoxApp < Sinatra::Base
  set :method_override, true
  set :root, 'lib/app'

  not_found do
    erb :error
  end

  get '/' do
    erb :index, locals: {ideas: IdeaStore.all.sort, idea: Idea.new}
  end

  get '/:id/edit' do |id|
    idea = IdeaStore.find(id.to_i)
    erb :edit, locals: {idea: idea}
  end

  post '/:id/like' do |id|
    idea = IdeaStore.find(id.to_i)
    idea.like!
    IdeaStore.update(id.to_i, idea.to_h)
    redirect '/'
  end

  post '/' do
    IdeaStore.create(params[:idea])
    redirect '/'
  end

  # post '/' do
  #   idea = Idea.new(params[:idea])
  #   idea.save
  #   redirect '/'
  # end

  delete '/:id' do |id|
    IdeaStore.delete(id.to_i)
    redirect '/'
  end

  get '/:id/edit' do |id|
    idea = IdeaStore.find(id.to_i)
    erb :edit, locals: {id: id, idea: idea}
  end

  put '/:id' do |id|
    IdeaStore.update(id.to_i, params[:idea])
    redirect '/'
  end
end

# class IdeaBoxApp < Sinatra::Base
#   set :method_override, true

#   not_found do
#     erb :error
#   end

#   configure :development do
#     register Sinatra::Reloader
#   end

#   get '/' do
#     erb :index, locals: {ideas: Idea.all, idea: Idea.new}
#   end

#   get '/:id/edit' do |id|
#     idea = Idea.find(id.to_i)
#     erb :edit, locals: {id: id, idea: idea}
#   end

#   post '/' do
#     idea = Idea.new(params[:idea])
#     idea.save
#     redirect '/'
#   end

#   delete '/:id' do |id|
#     Idea.delete(id.to_i)
#     redirect '/'
#   end

#   put '/:id' do |id|
#     Idea.update(id.to_i, params[:idea])
#     redirect '/'
#   end

# end
