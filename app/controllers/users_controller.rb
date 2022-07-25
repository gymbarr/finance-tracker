class UsersController < ApplicationController
  # get user tracked stocks
  def my_portfolio
    @tracked_stocks = current_user.stocks
  end
end
