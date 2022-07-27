class UsersController < ApplicationController
  # get user tracked stocks
  def my_portfolio
    @tracked_stocks = current_user.stocks
  end

  def my_friends
    @friends = current_user.friends
  end

  def search
    # if search input is not empty
    if params[:friend].present?
      # get the User object by email
      @friends = User.search(params[:friend])
      # exclude current user from search results
      @friends = current_user.except_current_user(@friends)
      if @friends
        # execute script for rendering search results (see users/_friend_result.js.erb)
        respond_to do |format|
          format.js { render partial: 'users/friend_result' }
        end
      else
        # if symbol wasn't found display alert message
        respond_to do |format|
          flash.now[:alert] = "User not found"
          format.js { render partial: 'users/friend_result' }
        end
      end
    else
      # display alert message if nothing was entered to search
      respond_to do |format|
        flash.now[:alert] = "Enter an email to search"
        format.js { render partial: 'users/friend_result' }
      end
    end
  end

end
