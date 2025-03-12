class Like < ApplicationRecord
  belongs_to :fan, class_name: "User", counter_cache: true
  belongs_to :photo, counter_cache: true

  validates :fan_id, uniqueness: { scope: :photo_id, message: "has already liked this photo" }

  # TODO fix current user
  after_create_commit -> { 
    broadcast_replace_to "likes_photo_#{photo_id}", target: "likes_photo_#{photo_id}", partial: "photos/likes", locals: { photo: photo, current_user: fan}
  }

  after_destroy_commit -> { 
    broadcast_replace_to "likes_photo_#{photo_id}", target: "likes_photo_#{photo_id}", partial: "photos/likes", locals: { photo: photo, current_user: fan}
  }
end
