class CreateAssociations < ActiveRecord::Migration
  def change
    create_table :associations do |t|
      t.references :movie, index: true
      t.references :artist, index: true
      t.integer :kind

      t.timestamps
    end
  end
end
