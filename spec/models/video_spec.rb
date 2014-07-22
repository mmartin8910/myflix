
require 'rails_helper'

RSpec.describe Video, type: :model do

  it "saves itself" do
    new_video = Video.new(title: 'My Video Title', description: 'My lengthy video description.', poster_small_url: 'my_small_cover_url.jpg', poster_large_url: 'my_large_cover_url.jpg')
    new_video.save

    saved_video = Video.first
    expect(saved_video.title).to eq('My Video Title')
    expect(saved_video.description).to eq('My lengthy video description.')
    expect(saved_video.poster_small_url).to eq('my_small_cover_url.jpg')
    expect(saved_video.poster_large_url).to eq('my_large_cover_url.jpg')
  end
end
