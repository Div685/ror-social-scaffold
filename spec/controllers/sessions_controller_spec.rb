require 'rails_helper'

RSpec.describe UsersController, type: :feature do
  describe 'SignUp process' do
    it 'create User' do
      sign_up('Divyesh', 'div@gmail.com', '123123123', '123123123')

      expect(page).to have_content('Welcome! You have signed up successfully.')
    end
  end

  describe 'Sign in Process' do
    it 'Sign User in' do
      login('div@gmail.com', '123123123')

      expect(page).to have_content('Signed in successfully.')
    end
  end
end
