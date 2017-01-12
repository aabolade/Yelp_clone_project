require 'rails_helper'

feature "endorsing reviews" do
  include Helpers
  user = {
    email: 'test@example.com',
    password: 'testtest'
  }
  restaurant = {
    name: "Zen"
  }
  before do
    sign_up(user)
    add_restaurant(restaurant)
    click_link "Review Zen"
    fill_in "Thoughts", with: "A piece of heaven"
    select '5', from: "Rating"
    click_button "Leave Review"
  end

  scenario "a user can endorse a review, which updates the review endorsement count" do
    visit '/restaurants'
    click_link "Endorse Review"
    expect(page).to have_content('1 endorsement')
  end

end
