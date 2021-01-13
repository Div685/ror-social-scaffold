require 'rails_helper'

RSpec.describe CommentsController, type: :feature do
    before :each do
        sign_up_user('Divyesh', 'div@gmail.com', '123123123', '123123123')
        login('div@gmail.com', '123123123')
    end

    describe 'Comment Management' do
        
        it 'create Comment' do
            visit root_path
            fill_in 'post[content]', with: 'Hello World'
            click_button('Save')
            sleep 1
            fill_in 'comment[content]', with: 'Nice Work'
            click_button('Comment')

            expect(page).to have_content('Comment was successfully created.')
        end
    end
end