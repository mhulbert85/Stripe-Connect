class User < ApplicationRecord
  def create_express_account
    Stripe::ExpressAccount.new(self).create
  end

  def destroy_express_account(stripe_id)
    Stripe::ExpressAccount.new(self).destroy(stripe_id)
  end
end
