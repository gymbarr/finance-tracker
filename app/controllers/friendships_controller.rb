class FriendshipsController < ApplicationController


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