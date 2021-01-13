require 'rails_helper'

RSpec.describe UsersController, type: :feature do
    before :each do
        # User.create(name: 'Divyesh', email: 'div@gmail.com', password: '123456', password_confirmation: '123456')
        # User.create(name: 'John', email: 'john@gmail.com', password: '123456', password_confirmation: '123456')
        # sign_up_user('Divyesh', 'div@gmail.com', '123123123', '123123123')
        # sign_up_user('John', 'john@gmail.com', '123123123', '123123123')
        visit root_path   
    end


    it 'send friend Request' do
        sign_up_user('Divyesh', 'div@gmail.com', '123123123', '123123123')
        sign_up_user('John', 'john@gmail.com', '123123123', '123123123')
        login('div@gmail.com', '123123123')
        send_invitation('john@gmail.com', '123123123')
        expect(page).to have_content('Your request has been sent!')
        sleep 1
        click_link('Sign out')
    end

    it 'confirm friend Request' do
        login('john@gmail.com', '123123123')
        click_link('John')
        click_link('accept')

        expect(page).to have_content('Request Accepted Successfully')
    end
    
end