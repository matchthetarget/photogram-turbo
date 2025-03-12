class FollowRequest < ApplicationRecord
  belongs_to :recipient, class_name: "User"
  belongs_to :sender, class_name: "User"

  enum :status, { pending: "pending", rejected: "rejected", accepted: "accepted" }

  # Automatic scopes from enum :status
  # scope :accepted, -> { where(status: "accepted" ) }
  # scope :not_accepted, -> { where.not(status: "accepted" ) }

  validates :recipient_id, uniqueness: { scope: :sender_id, message: "already requested" }

  validate :users_cant_follow_themselves

  def users_cant_follow_themselves
    if sender_id == recipient_id
      errors.add(:sender_id, "can't follow themselves")
    end
  end
end
