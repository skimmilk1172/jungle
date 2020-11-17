require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'Validations' do
    it 'should create valid user' do
      user = User.create(
        name: "Sean",
        email: "sean@kim.com",
        password: "skim",
        password_confirmation: "skim"
        )
      expect(user).to be_valid
    end

    it 'fails to save user if passwords do not match' do
      user = User.create(
        name: "Sean",
        email: "sean@kim.com",
        password: "skim",
        password_confirmation: "skimm"
        )
      expect(user).to_not be_valid
    end

    it 'fails to save user if email exists already (not case sensitive)' do
      user1 = User.create(
        name: "Sean",
        email: "sean@kim.com",
        password: "skim",
        password_confirmation: "skim"
        )
      user2 = User.create(
        name: "Sean",
        email: "sean@kim.com",
        password: "skim",
        password_confirmation: "skim"
        )
      expect(user2).to_not be_valid
    end

    it 'fails to save if no name' do
      user = User.create(
        email: "sean@kim.com",
        password: "skim",
        password_confirmation: "skim"
        )
        expect(user.errors.full_messages).to include "Name can't be blank"
    end

    it 'fails to save if no email' do
      user = User.create(
        name: "Sean",
        password: "skim",
        password_confirmation: "skim"
        )
        expect(user.errors.full_messages).to include "Email can't be blank"
    end

    it 'fails to save user if password length is less than 3' do
      user = User.create(
        name: "Sean",
        email: "sean@kim.com",
        password: "sk",
        password_confirmation: "sk"
        )
        expect(user.errors.full_messages).to include "Password is too short (minimum is 3 characters)"
    end
  end

  describe '.authenticate_with_credentials' do
    it 'logs in valid user' do
      user = User.create(
        name: "Sean",
        email: "sean@kim.com",
        password: "skim",
        password_confirmation: "skim"
        )
      loginUser = User.authenticate_with_credentials(user.email, user.password)
      expect(loginUser).to be true
    end

    it "logs in user with case insensitive email" do
      user = User.create(
        name: "Sean",
        email: "sean@kim.com",
        password: "skim",
        password_confirmation: "skim"
        )
      loginUser = User.authenticate_with_credentials('SeAn@kIm.com', user.password)
      expect(loginUser).to be true
    end

    it "logs in user with spaces around email" do
      user = User.create(
        name: "Sean",
        email: "sean@kim.com",
        password: "skim",
        password_confirmation: "skim"
        )
        loginUser = User.authenticate_with_credentials("  sean@kim.com ", user.password)
        expect(loginUser).to be true
      end
  end
end  