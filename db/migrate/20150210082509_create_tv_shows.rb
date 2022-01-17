# frozen_string_literal: true

class CreateTvShows < ActiveRecord::Migration[7.0]
  def change
    create_table :tv_shows do |t|
      t.string :title
      t.text :description
      t.integer :rank
      t.belongs_to :user

      t.timestamps null: false
    end
  end
end
