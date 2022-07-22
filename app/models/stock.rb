class Stock < ApplicationRecord

  def self.new_lookup(ticker_symbol)
    # connect to the IEX API
    client = IEX::Api::Client.new(
      publishable_token: Rails.application.credentials.iex_client[:sandbox_publish_key],
      secret_token: Rails.application.credentials.iex_client[:sandbox_secret_key],
      endpoint: 'https://sandbox.iexapis.com/v1'
    )
    
    begin
    # return Stock object in success scenario
      new(ticker: ticker_symbol, name: client.company(ticker_symbol).company_name, last_price: client.price(ticker_symbol))
    rescue => exception
      # if the exception was thrown return nil
      nil
    end
  end
end
