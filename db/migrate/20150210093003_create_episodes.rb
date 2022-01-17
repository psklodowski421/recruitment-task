# frozen_string_literal: true

class CreateEpisodes < ActiveRecord::Migration[7.0]
  def change
    create_table :episodes do |t|
      t.integer :tv_show_id, null: false
      t.string :title
      t.integer :episode
      t.boolean :watched

      t.timestamps null: false
    end
  end
end
