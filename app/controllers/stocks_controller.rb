class StocksController < ApplicationController

  def search
    # if search input is not empty
    if params[:stock].present?
      # get the Stock object with all params
      @stock = Stock.new_lookup(params[:stock])
      if @stock
        # execute script for rendering search results (see users/_stock_result.js.erb)
        respond_to do |format|
          format.js { render partial: 'users/stock_result' }
        end
      else
        # if symbol wasn't found display alert message
        respond_to do |format|
          flash.now[:alert] = "Symbol not found"
          format.js { render partial: 'users/stock_result' }
        end
      end
    else
      # display alert message if nothing was entered to search
      respond_to do |format|
        flash.now[:alert] = "Enter a symbol to search"
        format.js { render partial: 'users/stock_result' }
      end
    end
  end
  
end