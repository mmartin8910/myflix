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
#  token           :string(255)
#  admin           :boolean
#  customer_token  :string(255)
#

class User < ActiveRecord::Base
  include Tokenable

  has_secure_password validations: false

  has_many :queue_items, -> { order('list_order') }
  has_many :reviews, -> { order('created_at DESC') }
  has_many :follower_relationships, class_name: 'Relationship', foreign_key: :follower_id
  has_many :leader_relationships, class_name: 'Relationship', foreign_key: :leader_id

  validates_presence_of :email_address, :password, :full_name
  validates_uniqueness_of :email_address

  def normalize_list_order
    queue_items.each_with_index do |queue_item, index|
      queue_item.update_attributes(list_order: index + 1)
    end
  end

  def queued_video?(video)
    queue_items.map(&:video).include?(video)
  end

  def average_rating
    if self.reviews.count >= 1
      total = 0.0
      self.reviews.each do |review|
        total += ( review[:rating] || 0.0 )
      end
      (total / self.reviews.count).round(1)
    else
      0.0
    end
  end

  # def can_follow?(another_user)
  #   if self == another_user || self.follower_relationships.map(&:leader_id).include?(another_user.id)
  #     return false
  #   else
  #     return true
  #   end
  # end

  def can_follow?(another_user)

    !(self == another_user || self.follower_relationships.map(&:leader_id).include?(another_user.id))
  end

  def follows?(another_user)

    follower_relationships.map(&:leader_id).include?(another_user.id)
  end

  def follow(another_user)

    follower_relationships.create(leader_id: another_user.id) if can_follow?(another_user)
  end

  def deactivate!

    update_column(:active, false)
  end
end
