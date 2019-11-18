# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'Validations' do
    it 'Valid with all fields' do
      user = User.new(name: 'Bob', email: 'Bob@bob.com', password: 'bob123', password_confirmation: 'bob123')
      user.save
      expect(user).to be_valid
    end

    it 'Not valid when password and password_confirmation do not match' do
      user = User.new(name: 'Bob', email: 'bob@bob.com', password: 'bob123', password_confirmation: 'bob12')
      user.save
      expect(user).to_not be_valid
    end

    it 'Not valid when email #1 and email #2 do not match' do
      user = User.new(name: 'Bob1', email: 'bob@bob.com', password: 'bob123', password_confirmation: 'bob12')
      user2 = User.new(name: 'Bob2', email: 'bob@bob.com', password: 'bob123', password_confirmation: 'bob12')
      user.save
      user2.save
      expect(user2).to_not be_valid
    end

    it 'Not valid when a password is not present' do
      user = User.new(name: 'bob', email: 'bob@bob.com', password: nil, password_confirmation: nil)
      user.save
      expect(user).to_not be_valid
    end

    it 'Not valid when a password length is too short' do
      user = User.new(name: 'bob', email: 'bob@bob.com', password: '123', password_confirmation: '123')
      user.save
      expect(user).to_not be_valid
    end
  end

  describe '.authenticate_with_credentials' do
    it 'Login with the correct login details' do
      user = User.new(name: 'bob', email: 'bob@bob.com', password: 'bob123', password_confirmation: 'bob123')
      user.save!
      expect(user.authenticate_with_credentials('bob@bob.com', 'bob123')).to eql(user)
    end

    it 'Not login with the incorrect login details' do
      user = User.new(name: 'bob', email: 'bob@bob.com', password: 'bob123', password_confirmation: 'bob123')
      user.save!
      expect(user.authenticate_with_credentials('Bob@bob.com', 'bob12')).to_not eql(user)
    end
  end
end
