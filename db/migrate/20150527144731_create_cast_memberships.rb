class CreateCastMemberships < ActiveRecord::Migration
  def change
    create_table :cast_memberships do |t|
      t.references :movie, index: true
      t.references :artist, index: true
      t.string :role

      t.timestamps
    end
  end
end
