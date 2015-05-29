class AddYoutubeVideoIdToMovies < ActiveRecord::Migration
  def up
    add_column :movies, :youtube_video_id, :string
  end

  def down
    remove_column :movies, :youtube_video_id
  end
end
