require "rails_helper"

RSpec.describe 'Sign Up', type: :system do
  before do
    driven_by(:rack_test)
    @existing_user = User.create(name: 'Frank Sinatra', password: 'franky', password_confirmation: 'franky')
  end

  it 'allows a new user to sign up' do
    visit '/users/new'

    expect {
      fill_in 'Name', with: 'Joey'
      fill_in 'Password', with: 'joeyjo'
      fill_in 'Password Confirmation', with: 'joeyjo'
      click_on 'Sign Up'
    }.to change(User, :count).by(1)

    expect(page).to have_content 'Welcome'
  end

  it 'allows an existing user to login' do
    visit '/'

    expect {
      fill_in 'Name', with: @existing_user.name
      fill_in 'Password', with: @existing_user.password
      click_on 'Log in'
    }.not_to change(User, :count)

    expect(page).to have_content 'Welcome'
  end

  it 'prevents login for blank name' do
    visit '/'

    # don't fill in name
    fill_in 'Password', with: @existing_user.password
    click_on 'Log in'

    expect(page).to have_content 'Invalid name/password'
  end

  it 'prevents login for blank password' do
    visit '/'

    # don't fill in name
    fill_in 'Password', with: @existing_user.password
    click_on 'Log in'

    expect(page).to have_content 'Invalid name/password'
  end

  describe 'main menu' do
    before do
      visit '/'
      fill_in 'Name', with: @existing_user.name
      fill_in 'Password', with: @existing_user.password
      click_on 'Log in'
    end

    xit 'allows a user to start a game' do
      click_on 'Play Game'
      expect(page).to have_content '2 Player'
    end

    xit 'allows a user to view the Leaderboard' do
      click_on 'Leaderboard'
      expect(page).to have_content 'High Score'
    end

    it 'allows a user to view the rules' do
      click_on 'How to Play'
      expect(page).to have_content 'OBJECT OF THE GAME'
    end

    it 'allows a user to log out' do
      click_on 'Log Out'
      expect(page).to have_content 'Log Out Successful'
      visit '/sessions'
      expect(page).to have_content 'Log in to continue'
    end

    it 'allows a user to go "back" one page' do
      click_on 'chevron_left icon'
      expect(page).to have_content 'Go Fish!'
    end

    it 'allows a user to access the settings page' do
      click_on 'settings icon'
      expect(page).to have_content 'Settings'
    end
  end
end
