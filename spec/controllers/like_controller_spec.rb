require 'rails_helper'

RSpec.describe LikesController, type: :feature do
  before :each do
    sign_up_user('Divyesh', 'div@gmail.com', '123123123', '123123123')
    login('div@gmail.com', '123123123')
  end

  describe 'Like management' do
    it 'Like comment' do
      visit root_path
      fill_in 'post[content]', with: 'Hello World'
      click_button('Save')
      sleep 1
      click_link('Like!')

      expect(page).to have_content('You liked a post.')
    end
  end
end
