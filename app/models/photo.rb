class Photo < ApplicationRecord
  belongs_to :owner, class_name: "User", counter_cache: true

  has_many :comments, dependent: :destroy

  has_many :likes, dependent: :destroy

  has_many :fans, through: :likes

  validates :caption, presence: true

  validates :image, presence: true, url: true

  scope :latest, -> { order(created_at: :desc) }

  after_update_commit -> { broadcast_replace_to "photo_#{id}", target: "photo_#{id}", partial: "photos/placeholder", locals: { photo: self} }
end
