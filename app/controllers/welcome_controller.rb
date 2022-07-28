class WelcomeController < ApplicationController

  def index
    redirect_to my_portfolio_path
  end
  
end
