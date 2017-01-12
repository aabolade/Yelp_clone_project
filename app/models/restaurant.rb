class Restaurant < ApplicationRecord
  belongs_to :user
  has_many :reviews,
        -> { extending WithUserAssociationExtension },
        dependent: :destroy

  validates :name, length: {minimum: 3}, uniqueness: true

  has_attached_file :image, :styles => { :medium => "300x300>", :thumb => "100x100"}, :default_url => "/images/:style/missing.png"
  validates_attachment_content_type :image, :content_type => /\Aimage\/.*\Z/

  def belongs_to_user?(user)
    self.user == user
  end

  def average_rating
    return "N/A" if self.reviews == []
    self.reviews.inject(0) {|memo, review| memo + review.rating}/ (self.reviews.length)
  end

end
