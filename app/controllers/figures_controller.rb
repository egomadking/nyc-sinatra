class FiguresController < ApplicationController
  # add controller methods

  get '/figures' do
    @figures = Figure.all
    erb :'figures/index'
  end

  get '/figures/new' do
    @titles = Title.all
    @landmarks = Landmark.all
    erb :'figures/new'
  end

  get '/figures/:id' do
    @figure = Figure.find(params[:id])
    @titles = Title.all
    @landmarks = Landmark.all
    erb :'figures/show'
  end

  get '/figures/:id/edit' do
    @figure = Figure.find(params[:id])
    @titles = Title.all
    @landmarks = Landmark.all
    erb :'figures/edit'
  end

  post '/figures' do
    figure = Figure.create(:name => params[:figure][:name])
    if !!params[:figure][:title_ids]
      params[:figure][:title_ids].each do |id|
        Title.find(id).figures << figure
      end
    end

    if !!params[:title][:name] && params[:title][:name].length > 0
      figure.titles << Title.create(:name => params[:title][:name])
    end

    if !!params[:figure][:landmark_ids]
      params[:figure][:landmark_ids].each do |id|
        landmark = Landmark.find(id)
        landmark.update(:figure => figure)
      end
    end

    if !!params[:landmark][:name] && params[:landmark][:name].length > 0
      figure.landmarks << Landmark.create(:name => params[:landmark][:name], :year_completed => params[:landmark][:year_completed])
    end
    #binding.pry
    #redirect to :
  end

  patch '/figures/:id' do
    @figure = Figure.find(params[:id])
    @figure.name = params[:figure][:name]
    
    #binding.pry

    @figure.titles.clear
    if !!params[:figure][:title_ids]
      params[:figure][:title_ids].each do |id|
        Title.find(id).figures << @figure
      end
    end

    @figure.landmarks.clear
    if !!params[:figure][:landmark_ids]
      params[:figure][:landmark_ids].each do |id|
        landmark = Landmark.find(id)
        landmark.update(:figure => @figure)
      end
    end

    if !!params[:title][:name] && params[:title][:name].length > 0
      @figure.titles << Title.create(:name => params[:title][:name])
    end

    if !!params[:landmark][:name] && params[:landmark][:name].length > 0
      @figure.landmarks << Landmark.create(:name => params[:landmark][:name], :year_completed => params[:landmark][:year_completed])
    end

    @figure.save
    #create new title if needed
    #create new landmark if needed.
    redirect to "/figures/#{@figure[:id]}"
  end
end
