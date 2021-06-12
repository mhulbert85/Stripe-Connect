module Stripe
  class ExpressAccount
    attr_reader :user

    def initialize(user)
      @user = user
    end

    def create
      account = Stripe::Account.create({
        type: "express",
        country: "US",
        email: 'benny.rosen@example.com',
        capabilities: {
          card_payments: { 'requested': true },
          transfers: { 'requested': true },
        },
      })
      return account.id
    end

    def destroy(stripe_id)
      Stripe::Account.delete(stripe_id)
    end
  end
end
