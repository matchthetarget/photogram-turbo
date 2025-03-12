class Photo < ApplicationRecord
  belongs_to :owner, class_name: "User", counter_cache: true

  has_many :comments, dependent: :destroy

  has_many :likes, dependent: :destroy

  has_many :fans, through: :likes

  validates :caption, presence: true

  validates :image, presence: true, url: true
end
