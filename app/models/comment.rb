class Comment < ApplicationRecord
  belongs_to :author, class_name: "User", counter_cache: true
  belongs_to :photo, counter_cache: true

  validates :body, presence: true

  scope :default_order, -> { order(created_at: :asc) }

  # after_create_commit -> { broadcast_before_to "comments_photo_#{photo_id}", target: "comments_photo_#{photo_id}_form", partial: "comments/placeholder" }
  # after_update_commit -> { broadcast_replace_to "comment_#{id}", partial: "comments/placeholder" }
  # after_destroy_commit -> { broadcast_remove_to "comments_#{id}" }
end
