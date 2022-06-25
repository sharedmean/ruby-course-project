require 'rails_helper'
require 'spec_helper'

RSpec.describe 'User page', :js, type: :feature do

    scenario 'user loggs in' do
      visit signin_path 
      
      within('#new_user') do
        fill_in 'user_email', :with => 'skor.julia@bk.ru'
        fill_in 'user_password', :with => 'qwqwqw'
      end
      click_button 'commit'
  
      expect(page).to have_content("Signed in successfully")
    end

    scenario 'user signs up' do
      visit signup_path 
      within('#new_user') do
        fill_in 'user_username', :with => FFaker::Name.name
        fill_in 'user_email', :with => FFaker::Internet.email 
        fill_in 'user_password', :with => 'qwqwqw'
        fill_in 'user_password_confirmation', :with => 'qwqwqw'
      end
      click_button 'commit'

      expect(page).to have_content("Welcome! You have signed up successfully")
    end

    scenario 'user loggs in with invalid password' do
      visit signin_path 
      
      within('#new_user') do
        fill_in 'user_email', :with => 'skor.julia@bk.ru'
        fill_in 'user_password', :with => '121212'
      end
      click_button 'commit'

      expect(page).to have_content("Invalid Email or password")
    end

    scenario 'user signs up with existed username' do
      visit signup_path 
      
      within('#new_user') do
        fill_in 'user_username', :with => 'shared_mean'
        fill_in 'user_email', :with => FFaker::Internet.email 
        fill_in 'user_password', :with => 'qwqwqw'
        fill_in 'user_password_confirmation', :with => 'qwqwqw'
      end
      click_button 'commit'
  
      expect(page).to have_content("Username has already been taken")
    end

    scenario 'user signs up with existed email' do
      visit signup_path 
      
      within('#new_user') do
        fill_in 'user_username', :with => FFaker::Name.name
        fill_in 'user_email', :with => 'skor.julia@bk.ru'
        fill_in 'user_password', :with => 'qwqwqw'
        fill_in 'user_password_confirmation', :with => 'qwqwqw'
      end
      click_button 'commit'

      expect(page).to have_content("Email has already been taken")
    end

    scenario 'user signs up with empty username' do
      visit signup_path 
      
      within('#new_user') do
        fill_in 'user_email', :with => 'skor.julia@bk.ru'
        fill_in 'user_password', :with => 'qwqwqw'
        fill_in 'user_password_confirmation', :with => 'qwqwqw'
      end
      click_button 'commit'
  
      expect(page).to have_content("Username is too short (minimum is 4 characters)")
    end

    scenario 'user signs up with empty email' do
      visit signup_path 
      
      within('#new_user') do
        fill_in 'user_username', :with => FFaker::Name.name
        fill_in 'user_password', :with => 'qwqwqw'
        fill_in 'user_password_confirmation', :with => 'qwqwqw'
      end
      click_button 'commit'
  
      expect(page).to have_content("Email can't be blank")
    end

    scenario 'user signs up with empty password' do
      visit signup_path 
      
      within('#new_user') do
        fill_in 'user_username', :with => FFaker::Name.name
        fill_in 'user_email', :with => FFaker::Internet.email 
      end
      click_button 'commit'
      expect(page).to have_content("Password can't be blank")
    end

    scenario 'user signs up with not similar passwords' do
      visit signup_path 
      
      within('#new_user') do
        fill_in 'user_username', :with => FFaker::Name.name
        fill_in 'user_email', :with => FFaker::Internet.email 
        fill_in 'user_password', :with => 'qwqwqw'
        fill_in 'user_password_confirmation', :with => '121212'
      end
      click_button 'commit'
      expect(page).to have_content("Password confirmation doesn't match Password")
    end
  
end  