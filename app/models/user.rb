class User < ApplicationRecord
  has_many :user_stocks
  has_many :stocks, through: :user_stocks
  
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  

  def stock_already_tracked?(ticker_symbol)
    # check if stock exist in db
    stock = Stock.check_db(ticker_symbol)
    return false unless stock
    # check if a user has this stock by his id
    stocks.where(id: stock.id).exists?
  end

  # restriction for maximum number of tracked stocks
  def under_stock_limit?
    stocks.count < 5
  end

  # overal restriction of stocks tracking for users
  def can_track_stock?(ticker_symbol)
    under_stock_limit? && !stock_already_tracked?(ticker_symbol)
  end

  def full_name
    return "#{first_name} #{last_name}" if first_name || last_name
    "Anonymous"
  end

end
