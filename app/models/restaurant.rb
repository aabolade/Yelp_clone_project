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
    return "N/A" if self.reviews == []
    self.reviews.inject(0) {|memo, review| memo + review.rating}/ (self.reviews.length).to_f
  end

end
