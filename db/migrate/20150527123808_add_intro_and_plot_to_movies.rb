class AddIntroAndPlotToMovies < ActiveRecord::Migration
  def change
    add_column :movies, :intro, :text
    add_column :movies, :plot, :text
  end
end
