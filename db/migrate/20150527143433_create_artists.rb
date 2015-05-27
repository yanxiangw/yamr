class CreateArtists < ActiveRecord::Migration
  def change
    create_table :artists do |t|
      t.string :name
      t.attachment :portrait

      t.timestamps
    end
  end
end
