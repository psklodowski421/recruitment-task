# == Schema Information
#
# Table name: episodes
#
#  id         :integer          not null, primary key
#  tv_show_id :integer          not null
#  title      :string
#  episode    :integer
#  watched    :boolean
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

# frozen_string_literal: true

class Episode < ApplicationRecord
  belongs_to :tv_show
end
