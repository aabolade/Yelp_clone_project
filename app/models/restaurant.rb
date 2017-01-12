class Restaurant < ApplicationRecord
  belongs_to :user
  has_many :reviews,
        -> { extending WithUserAssociationExtension },
        dependent: :destroy

  validates :name, length: {minimum: 3}, uniqueness: true

  def belongs_to_user?(user)
    self.user == user
  end

  def average_rating
    "N/A"
  end

end
