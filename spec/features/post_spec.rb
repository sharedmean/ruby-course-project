require 'rails_helper'
require 'spec_helper'

# THE TROUBLES WERE:
# It gives me a mistake that Selenium::Logger is only on 4.3.0 selenium version 
# Selenium::Logger is available only on ruby 2.7.    amazing...
# go to ruby 2.7................... install 4.3.0 selenium
# have troubles with driver_path. Install chromedriver and add line [18] to spec_helper
# run this code on 4.3.0 version
# it gives me a mistake. I have to go to 2.53.4 version(decision from stackoverflow)
# this returns me THE MISTAKE from line [5] (great!............)
# I go back to 4.3.0 selenium, add geckodriver-helper gem. 
# and it FINALLY WORKS!
# it was a joke... haha...
# then a had troubles, 'cause I don't have chrome on my ubuntu
# I've changed line [18] in spec_helper to Firefox and geckodriver, commented chromedriver-helper in gemfile

RSpec.describe 'Posts page', :js, type: :feature do

  scenario 'user creates post' do
    login_as(FactoryBot.create(:user))

    visit posts_path 

    find("a[href='#{new_post_path}']").click

    expect(page).to have_content("Add New Post")

    within '.new-post' do
      fill_in 'post_title', with: "My first post"
      fill_in 'post_body', with: "Hi! It's my first post!"
      attach_file('post_picture', Rails.root.join('spec/fixtures/pixel.png'))

      click_button 'commit'
    end

    expect(page).to have_content("My first post")

    find("a[href='#{destroy_user_session_path}']").click
  end

  scenario 'user edits post' do
    user = FactoryBot.create(:user)
    login_as(user)
    post = FactoryBot.create(:post, user: user)

    visit posts_path 

    find("a[href='#{profile_path(user)}']").click
    find("a[href='#{post_path(post, profile: "profile_path")}']").click
    find("a[href='#{edit_post_path(post)}']").click
    
    expect(page).to have_content("Edit Post")

    within '.edit_post' do
      fill_in 'post_body', with: "Hi! It's my first post! Happy to be there!"

      click_button 'commit'
    end

    expect(page).to have_content("Hi! It's my first post! Happy to be there!")

    find("a[href='#{destroy_user_session_path}']").click
  end

  scenario 'user deletes post' do
    user = FactoryBot.create(:user)
    login_as(user)
    post = FactoryBot.create(:post, user: user)

    visit posts_path 

    find("a[href='#{profile_path(user)}']").click
    find("a[href='#{post_path(post, profile: "profile_path")}']").click
    find("a[href='#{post_path(post)}']").click

    page.driver.browser.switch_to.alert.accept

    find("a[href='#{profile_path(user)}']").click

    expect(page).not_to have_content("a[href='#{post_path(post, profile: "profile_path")}']")

    find("a[href='#{destroy_user_session_path}']").click
  end

  scenario 'user cancels post deletion' do
    user = FactoryBot.create(:user)
    login_as(user)
    post = FactoryBot.create(:post, user: user)

    visit posts_path 

    find("a[href='#{profile_path(user)}']").click
    find("a[href='#{post_path(post, profile: "profile_path")}']").click
    find("a[href='#{post_path(post)}']").click

    page.driver.browser.switch_to.alert.dismiss

    expect(page).to have_content(post.title)

    find("a[href='#{destroy_user_session_path}']").click
  end

  scenario 'user inputs too short title while editing' do
    user = FactoryBot.create(:user)
    login_as(user)
    post = FactoryBot.create(:post, user: user)

    visit posts_path 

    find("a[href='#{profile_path(user)}']").click
    find("a[href='#{post_path(post, profile: "profile_path")}']").click
    find("a[href='#{edit_post_path(post)}']").click
    
    expect(page).to have_content("Edit Post")

    within '.edit_post' do
      fill_in 'post_title', with: "!"

      click_button 'commit'
    end

    expect(page).to have_content("Title is too short (minimum is 2 characters)")

    find("a[href='#{destroy_user_session_path}']").click
  end
end

