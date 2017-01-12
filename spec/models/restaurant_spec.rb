require 'rails_helper'

describe Restaurant, type: :model do

  it 'is not valid with a name of less than 3 characters' do
    restaurant = Restaurant.new(name: "kf")
    expect(restaurant).to have(1).errors_on(:name)
    expect(restaurant).not_to be_valid
  end

  it "is not valid unless it has a unique name" do
    user = User.create(email: 'test@test.com', password: 'testest', password_confirmation: 'testtest')
    restaurant1 = Restaurant.new(name: "Itadaki Zen")
    restaurant1.user = user
    restaurant1.save
    restaurant = Restaurant.new(name: "Itadaki Zen")
    expect(restaurant).to have(1).error_on(:name)
  end

  describe "#average_rating" do
    context "no reviews" do
      it "Returns 'N/A' when thre are no reviews" do
        restaurant = Restaurant.create(name: "Leke's Best")
        expect(restaurant.average_rating).to eq "N/A"
      end
    end

    context "1 review" do
      it "returns that rating" do
        user = User.create(email: 'test@test.com', password: 'testest', password_confirmation: 'testtest')
        restaurant = Restaurant.new(name: "Itadaki Zen")
        restaurant.user = user
        restaurant.save
        restaurant.reviews.create(rating: 4)
        expect(restaurant.average_rating).to eq 4
      end
    end

    context "multiple reviews" do
      it "returns the average" do
        user = User.create(email: 'test@test.com', password: 'testest', password_confirmation: 'testtest')
        restaurant = Restaurant.new(name: "Itadaki Zen")
        restaurant.user = user
        restaurant.save
        restaurant.reviews.create(rating: 4)
        restaurant.reviews.create(rating: 2)
        expect(restaurant.average_rating).to eq 3
      end
    end


  end
end
