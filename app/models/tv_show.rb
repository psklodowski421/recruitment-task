# == Schema Information
#
# Table name: tv_shows
#
#  id          :integer          not null, primary key
#  title       :string
#  description :text
#  rank        :integer
#  user_id     :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

# frozen_string_literal: true

class TvShow < ApplicationRecord
  belongs_to :user
  has_many :episodes

  def to_json(_)
    ep = []
    episodes.each do |e|
      ep << { id: e.id, title: e.title }
    end

    JSON.generate({
                    id: id,
                    title: title,
                    episodes: ep
                  })
  end
end
