class Like < ApplicationRecord
  belongs_to :fan, class_name: "User", counter_cache: true
  belongs_to :photo, counter_cache: true

  validates :fan_id, uniqueness: { scope: :photo_id, message: "has already liked this photo" }

  after_create_commit -> { 
    broadcast_replace_to "likes_photo_#{photo_id}", target: "likes_count_photo_#{photo_id}", partial: "photos/likes_count", locals: { photo: photo }
  }

  after_destroy_commit -> { 
    broadcast_replace_to "likes_photo_#{photo_id}", target: "likes_count_photo_#{photo_id}", partial: "photos/likes_count", locals: { photo: photo }
  }
end
