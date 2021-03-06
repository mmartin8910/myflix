# == Schema Information
#
# Table name: categories
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  created_at :datetime
#  updated_at :datetime
#

class Category < ActiveRecord::Base

  has_many :video_categories
  has_many :videos, -> { order('created_at DESC') }, through: :video_categories

  validates :name, presence: true

  def most_recent
    videos.first(6)
  end
end
