# rubocop:disable Style/GuardClause

module UserHelper
  def send_friend_request(id, user)
    if sent_requests(id)
      if pending_requests(id)
        if current_user_requests(id)
          content_tag :span, 'pending'
        else
          link_to('Accept', user_accept_path(user), method: :post, class: 'accept-btn') +
            link_to('Reject', user_reject_path(user), method: :post, class: 'reject-btn')
        end

      else
        content_tag(:span, 'Friend') +
          link_to('Unfriend', user_unfriend_path(id), method: :delete, class: 'reject-btn')
      end
    else
      link_to('Send Request', user_invite_path(user), method: :post, class: 'send-btn')
    end
  end

  def my_friends(users, friends)
    if users == current_user
      list = ''
      friends.each do |f|
        list += content_tag :div, class: 'invitation' do
          content_tag :p, class: 'invitation-name' do
            content_tag(:span, "#{f.user.name} ", class: '') +
              'is your friend'.html_safe +
              link_to('Unfriend', user_unfriend_path(f.user.id), method: :delete, class: 'reject-btn')
          end
        end
      end
      list.html_safe
    end
  end

  def my_invite(user)
    if user == current_user

      list = ''
      pending_invitations.each do |requestee|
        list += content_tag :div, class: 'invitation' do
          content_tag :p, class: 'invitation-name' do
            content_tag(:span, "#{requestee.name} ", class: '') +
              'wants to be your friend'.html_safe +
              link_to('accept', user_accept_path(requestee), method: :post, class: 'accept-btn') +
              link_to('reject', user_reject_path(requestee), method: :post, class: 'reject-btn')
          end
        end
      end
      list.to_s.html_safe
    end
  end

  def not_current_user(id, user)
    link_css = 'btn-request invite-link'
    span_css = 'profile-link'
    f_request = 'Send Friend Request'
    if user != current_user
      if sent_requests(id)
        if pending_requests(id)
          content_tag :span, 'Pending'
        else
          content_tag(:span, 'Friend') +
            link_to('Unfriend', user_unfriend_path(id), method: :delete, class: 'reject-btn')
        end
      else
        content_tag(:span,
                    link_to(f_request.to_s, user_invite_path(user), method: :post, class: link_css.to_s),
                    class: span_css.to_s)
      end
    end
  end
end

# rubocop:enable Style/GuardClause
