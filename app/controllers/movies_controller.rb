class MoviesController < ApplicationController
  def index
    @movies = Movie.all
  end

  def show
    @movie = Movie.find(params[:id])
  end

  def new
    @movie = Movie.new
  end

  def edit
    @movie = Movie.find(params[:id])
  end

  def update
    @movie = Movie.find(params[:id])
    if @movie.update(movie_params)
      redirect_to movie_path(@movie), notice: "#{@movie.title} foi atualizado."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def create
    @movie = Movie.new(movie_params)
    if @movie.save
      redirect_to movies_path, notice: "#{@movie.title} foi criado."
    else
      render :new, status: :unprocessable_entity
    end
  end

   def destroy
    @movie = Movie.find(params[:id])
    @movie.destroy
    redirect_to movies_path, notice: "Filme '#{@movie.title}' apagado."
  end

  

  private

  def movie_params
    params.require(:movie).permit(:title, :rating, :description, :release_date)
  end
end
