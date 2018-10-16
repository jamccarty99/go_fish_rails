require 'rails_helper'

RSpec.describe User, type: :model do
  describe '#name' do
    before do
      @user = User.new(name: "Example User", password: "foobar", password_confirmation: "foobar")
    end

    it 'is required' do
      @user.name = ""
      expect(@user.valid?).not_to be(true)
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

    # it 'must be unique' do
    #   @user
    #   new_user = User.new(name: "Example User", password: "foobar", password_confirmation: "foobar")
    #
    #   expect(new_user.valid?).not_to be(true)
    #   expect {
    #     new_user.save!
    #   }.to raise_error ActiveRecord::RecordInvalid
    # end
  end

  describe '#password' do
    before do
      @user = User.new(name: "Example User", password: "foobar", password_confirmation: "foobar")
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
end
