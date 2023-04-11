class Admin::GenresController < ApplicationController

  def index
    @genre = Genre.new
    @genres = Genre.all
  end

  def create
    @genre = Genre.new(genre_params)
    if @genre.save
       flash[:notice] = "新しいジャンルを追加しました"
      redirect_to admin_genres_path
    else
      render 'admin/genres'
    end
  end


  def edit
    @genre = Genre.find(params[:id])
  end

  def update
    @genre = Genre.find(params[:id])
    if @genre.update(genre_params)
      flash[:notice] = "更新しました"
      redirect_to admin_genres_path
    else
      render :edit
    end
  end

  #ストロングパラメータ
  private
  def genre_params
    params.require(:genre).permit(:name)
  end

end
