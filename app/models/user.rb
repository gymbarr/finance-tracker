class User < ApplicationRecord
  has_many :user_stocks
  has_many :stocks, through: :user_stocks
  has_many :friendships
  has_many :friends, through: :friendships
  
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

  def user_already_followed?(user)
    friends.include?(user)
  end

  def full_name
    return "#{first_name} #{last_name}" if first_name || last_name
    "Anonymous"
  end

  def self.search(param)
    # remove leading and trailing whitespaces from search string
    param.strip!
    to_send_back = (first_name_matches(param) + last_name_matches(param) + email_matches(param)).uniq

    to_send_back ? to_send_back : nil
  end

  # get rows by first_name field and searching string in param 
  def self.first_name_matches(param)
    matches('first_name', param)
  end

  # get rows by last_name field and searching string in param 
  def self.last_name_matches(param)
    matches('last_name', param)
  end

  # get rows by email field and searching string in param 
  def self.email_matches(param)
    matches('email', param)
  end

  # retreives rows from the table by field name and searching string in param 
  def self.matches(field_name, param)
    where("#{field_name} like ?", "%#{param}%")
  end

  # remove current user from collection of users
  def except_current_user(users)
    users.reject { |user| user.id == self.id }
  end

end
