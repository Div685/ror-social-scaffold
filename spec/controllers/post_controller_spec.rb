require 'rails_helper'

RSpec.describe PostsController, type: :feature do
  let(:post_params) do
    {
      content: 'Hello World'
    }
  end
  let(:post) do
    Post.new(post_params)
  end

  describe 'Post Management' do
    before :each do
      sign_up_user('Divyesh', 'div@gmail.com', '123123123', '123123123')
      login('div@gmail.com', '123123123')
    end

    it 'Create Post' do
      visit root_path
      fill_in 'post[content]', with: 'Hello World'
      click_button('Save')

      expect(page).to have_content('Post was successfully created.')
    end
  end
end
