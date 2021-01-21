class UsersController < ApplicationController
  before_action :authenticate_user!

  def index
    @users = User.where('id != ?', current_user.id).order('name ASC')
  end

  def show
    @user = User.find(params[:id])
    @posts = @user.posts.ordered_by_most_recent
    @friends_lists = current_user.friends
  end

  def invite
    invitation = current_user.friendships.build(friend_id: params[:user_id])
    if User.check_request(current_user, params[:user_id])
      flash.notice = 'You already have pending Invitations'
      redirect_to users_path
    elsif invitation.save
      redirect_to users_path, notice: 'Your request has been sent!'
    end
  end

  def accept
    request = Friendship.find_by(user_id: params[:user_id], friend_id: current_user.id)

    request.status = true
    if request.save
      flash.notice = 'Friend Request Accepted!'
      friendship2 = current_user.friendships.build(friend_id: params[:user_id], status: true)

      friendship2.save
    else
      flash.notice = 'Friend Request could not be Accepted!'
    end

    redirect_to user_path(current_user), notice: 'Request Accepted Successfully'
  end

  def reject
    request = Friendship.find_by(user_id: params[:user_id], friend_id: current_user.id)
    request.destroy

    redirect_to users_path, notice: 'Request has been declined'
  end

  def unfriend
    request = Friendship.find_by(user_id: params[:user_id], friend_id: current_user.id)
    request2 = Friendship.find_by(user_id: current_user.id, friend_id: params[:user_id])

    if request.present? && request2.present?
      request.destroy
      request2.destroy
      flash.notice = 'Successfully Unfriended'
    else
      flash.notice = 'Something went Wrong! Could not be unfriended!'
    end

    redirect_to users_path, notice: 'Request Successfully Unfriended!'
  end
end
