class Review < ApplicationRecord
  belongs_to :user
  belongs_to :restaurant

  validates :rating, inclusion: (1..5)
  validates :user, uniqueness: { scope: :restaurant, message: "has reviewed this restaurant already" }

  has_many :endorsements
  
  def belongs_to?(user)
    self.user == user
  end

end
