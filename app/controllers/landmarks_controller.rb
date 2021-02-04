class LandmarksController < ApplicationController
  # add controller methods
  get '/landmarks' do
    @landmarks = Landmark.all
    erb :'landmarks/index'
  end

  get '/landmarks/new' do
    erb :'landmarks/new'
  end

  get '/landmarks/:id' do
    @landmark = Landmark.find(params[:id])
    erb :'landmarks/show'
  end

  patch '/landmarks/:id' do
    @landmark = Landmark.find(params[:id])
    @landmark.update(:name => params[:landmark][:name], :year_completed => params[:landmark][:year_completed])
    redirect to "/landmarks/#{params[:id]}"
  end

  get '/landmarks/:id/edit' do
    @landmark = Landmark.find(params[:id])
    erb :'landmarks/edit'
  end

  post '/landmarks' do
    @landmark = Landmark.create(:name => params[:landmark][:name], :year_completed => params[:landmark][:year_completed])
    #redirect to "/landmarks/#{@lanmark.id}"
  end
end
