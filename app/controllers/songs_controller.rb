class SongsController < ApplicationController
  before_action :finds_song, only: [:update, :edit, :destroy, :show]

  def index
    # Helper method for fun 
    @songs = get_model_name_find_all
  end

  def show
  end

  def new
    @song = Song.new
  end

  def create
    @song = Song.new(song_params)
    @song.artist = Artist.find_or_create_by(artist_params)

    if @song.save
      redirect_to @song
    else
      render :new
    end
  end

  def edit
  end

  def update

    @song.update(song_params)

    if @song.save
      redirect_to @song
    else
      render :edit
    end
  end

  def destroy
    @song.destroy
    flash[:notice] = "Song deleted."
    redirect_to songs_path
  end

  private

  def song_params
    params.require(:song).permit(:title)
  end

  def finds_song
    @song = Song.find(params[:id])
  end

  def artist_params
    params.require(:artist).permit(:name)
  end
end
