# == Schema Information
#
# Table name: users
#
#  id              :integer          not null, primary key
#  email_address   :string(255)
#  password_digest :string(255)
#  full_name       :string(255)
#  created_at      :datetime
#  updated_at      :datetime
#

require 'rails_helper'

RSpec.describe User, type: :model do

  it { should have_secure_password }

  it { should have_many(:queue_items).order('list_order') }
  it { should have_many(:reviews).order('created_at DESC') }

  it { should validate_presence_of(:email_address) }
  it { should validate_presence_of(:password) }
  it { should validate_presence_of(:full_name) }
  it { should validate_uniqueness_of(:email_address) }

  it 'generates a random token with a user is created' do
    user = Fabricate(:user)
    expect(user.token).to be_present
  end

  it_behaves_like 'is tokenable' do
    let(:object) { Fabricate(:user) }
  end
end
