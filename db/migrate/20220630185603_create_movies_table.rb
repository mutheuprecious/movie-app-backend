class CreateMoviesTable < ActiveRecord::Migration[6.1]
  def change
      create_table :movies do | t | 
        t.string :movie_name
        t.string :movie_poster
        t.string :movie_year 
        t.datetime :created_at
        t.datetime :updated_at 
      end
      end
  end
end
