class UsersController < ApplicationController
  def index
    session[:url] = request.original_url                            # Store root url for stripe
    @stripe_id = session[:stripe_id]                                # Instance variable to be used in view
  end

  def create_stripe_id
    user = User.first                                               # Users are not dynamic in this demo -  user = User.find params[:id]
    return session[:stripe_id] = user.create_express_account        # Call create express account method from user model
  end

  def create_account_link
    stripe_id = create_stripe_id                                    # Call create stripe id method
    url = session[:url]
    account_link = Stripe::AccountLink.create({
      account: stripe_id,
      refresh_url: url,
      return_url: url,
      type: "account_onboarding",
    })
    redirect_to account_link.url                                    # Redirect to stripe url
  end

  def destroy
    user = User.first                                               # Users are not dynamic in this demo -  user = User.find params[:id]
    stripe_id = session.delete(:stripe_id)                          # Clear session[:stripe_id]
    user.destroy_express_account(stripe_id)                         # Call method from user model & destroy stripe account
    redirect_to root_path
  end
end
