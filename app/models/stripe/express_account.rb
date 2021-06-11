module Stripe
  class ExpressAccount
    attr_reader :user

    def initialize(user)
      @user = user
    end

    def create
      if @user.stripe_id.nil?
        account = Stripe::Account.create({
          type: "express",
          country: "US",
          email: @user.email,
          capabilities: {
            card_payments: { 'requested': true },
            transfers: { 'requested': true },
          },
        })
        @user.update_column(:stripe_id, account.id)  # Save stripe id in user table
      end
    end
  end
end
