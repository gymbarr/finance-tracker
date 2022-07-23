class StocksController < ApplicationController
  def search
    # if search input is not empty
    if params[:stock].present?
      # get the Stock object with all params
      @stock = Stock.new_lookup(params[:stock])
      if @stock
        # execute script for rendering search results (see users/_result.js.erb)
        respond_to do |format|
          format.js { render partial: 'users/result' }
        end
      else
        # if symbol wasn't found display alert message
        flash[:alert] = "Symbol not found"
        redirect_to my_portfolio_path
      end
    else
      # display alert message
      flash[:alert] = "Enter a symbol to search"
      redirect_to my_portfolio_path
    end
  end
end