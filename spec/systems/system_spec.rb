require "rails_helper"

RSpec.describe 'Sign Up', type: :system do
  before do
    driven_by(:rack_test)
  end

  it 'allows a new user to sign up' do
    visit '/'

    expect {
      fill_in :username, with: 'Caleb'
      click_on 'Login'
    }.to change(User, :count).by(1)

    expect(page).to have_content 'Pending Games'
  end

  it 'allows an existing user to login' do
    existing_user = create(:user, name: 'Caleb')
    visit '/'

    expect {
      fill_in 'Name', with: 'Caleb'
      click_on 'Login'
    }.not_to change(User, :count)

    expect(page).to have_content 'Pending Games'
  end

  it 'prevents login for blank name' do
    visit '/'

    # don't fill in name
    click_on 'Login'

    expect(page).to have_content 'error'
  end

  it "invalid signup information" do
    get signup_path
    assert_no_difference 'User.count' do
      post users_path, params: { user: { name:  "",
                                         password:              "foo",
                                         password_confirmation: "bar" } }
    end
    assert_template 'users/new'
  end
end
