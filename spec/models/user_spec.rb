require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    @user = User.new(name: "Example User", password: "foobar", password_confirmation: "foobar")
  end

  it "should be valid" do
    expect(@user.valid?).to be(true)
  end

  it "name should be present" do
    @user.name = "     "
    expect(@user.valid?).to_not be(true)
  end

   it "name should not be too long" do
    @user.name = "a" * 51
    expect(@user.valid?).to_not be(true)
  end

  it "password should be present (nonblank)" do
    @user.password = @user.password_confirmation = " " * 6
    expect(@user.valid?).to be(false)
  end

  it "password should have a minimum length" do
    @user.password = @user.password_confirmation = "a" * 5
    expect(@user.valid?).to be(false)
  end
end
