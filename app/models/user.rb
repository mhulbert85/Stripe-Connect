class User < ApplicationRecord
  def create_express_account
    Stripe::ExpressAccount.new(self).create
  end
end
