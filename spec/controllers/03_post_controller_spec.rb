require 'rails_helper'

RSpec.describe PostsController, type: :feature, order: :defined do
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
      visit root_path
    end

    context 'When Create, Like and Comment a Post' do
      it 'Create Post' do
        sign_up_user('Batman', 'batman@gmail.com', '123123123', '123123123')
        login('batman@gmail.com', '123123123')
        visit root_path
        fill_in 'post[content]', with: 'Hello World'
        click_button('Save')

        expect(page).to have_content('Post was successfully created.')
      end

      it 'Like Post' do
        login('batman@gmail.com', '123123123')
        click_link('Like!')

        expect(page).to have_content('You liked a post.')
      end

      it 'Comment a Post' do
        login('batman@gmail.com', '123123123')
        fill_in 'comment[content]', with: 'Nice Work'
        click_button('Comment')

        expect(page).to have_content('Comment was successfully created.')
      end
    end
  end
end
