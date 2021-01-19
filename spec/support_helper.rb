module SupportHelpers
  def send_invitation(_email, _password)
    click_link('All users')
    click_link('Send Request')
  end

  def login(email, password)
    visit user_session_path
    fill_in('user[email]', with: email)
    fill_in('user[password]', with: password)
    click_button('Log in')
  end

  def sign_up(name, email, password, password_confirmation)
    visit new_user_registration_path
    fill_in 'user[name]', with: name
    fill_in 'user[email]', with: email
    fill_in 'user[password]', with: password
    fill_in 'user[password_confirmation]', with: password_confirmation
    click_button('Sign up')
  end

  def sign_up_user(name, email, password, password_confirmation)
    sign_up(name, email, password, password_confirmation)
    sleep 1
    click_link('Sign out')
  end
end
