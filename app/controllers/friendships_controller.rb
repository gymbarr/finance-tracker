class FriendshipsController < ApplicationController

  def create
    # check if entered user is already exist in db
    friend = User.find(params[:friend])

    # create relation between current user and other user in the friendships table
    @friendship = Friendship.create(user: current_user, friend: friend)
    flash[:notice] = "You are now following the user #{friend.first_name} #{friend.last_name}"
    redirect_to friends_path
  end

  def destroy
    # get stock object by stock id from users table
    friend = User.find(params[:id])
    # get friendship relation by friend id and current user id
    @friendship = Friendship.find_by(user_id: current_user[:id], friend_id: friend[:id])
    @friendship.destroy
    flash[:notice] = "You are not following the user #{friend.first_name} #{friend.last_name} anymore"
    redirect_to friends_path
  end

end