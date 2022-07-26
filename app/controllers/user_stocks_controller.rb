class UserStocksController < ApplicationController

  def create
    # check if entered stock is already exist in db
    stock = Stock.check_db(params[:ticker])

    # if not exist in db then connect to the API, retreive requested stock and save it to db
    if stock.blank?
      stock = Stock.new_lookup(params[:ticker])
      stock.save
    end

    # create relation in the user_stock table
    @user_stock = UserStock.create(user: current_user, stock: stock)
    flash[:notice] = "Stock #{stock.name} was successfully added to your portfolio"
    redirect_to my_portfolio_path
  end

  def destroy
    # get stock object by stock id from users table
    stock = Stock.find(params[:id])
    # get user-stock relation by stock id and current user id
    @user_stock = UserStock.find_by(user_id: current_user[:id], stock_id: stock[:id])
    @user_stock.destroy
    flash[:notice] = "Stock #{stock.name} was successfully deleted from your portfolio"
    redirect_to my_portfolio_path
  end

end
