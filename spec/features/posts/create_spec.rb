require "rails_helper"

RSpec.feature "Post", :type => :feature do

  scenario "Create a new post" do
    login_as (create(:admin))
    visit "blog/posts/new"

    @title = "teste"
    @body = Faker::Lorem.paragraphs(3).join(" ")
    fill_in 'post_title',      :with => @title
    fill_in "post_body",       :with => @body
    fill_in "tags",            :with => "teste;python;rails"

    click_button "Submit Post"

    #save_and_open_page

    expect(page).to have_text(@title)
    expect(page).to have_text(@body)

  end

end
