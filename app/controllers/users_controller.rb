class UsersController < ApplicationController
  # get user tracked stocks
  def my_portfolio
    @tracked_stocks = current_user.stocks
  end

  def my_friends
    @friends = current_user.friends
  end

end
