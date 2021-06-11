class UsersController < ApplicationController
  def index
    @user = User.first                  # Users are not dynamic in this demo
    @user.create_express_account        # call method from user model
    session[:page_url] = request.original_url # get home page url path
  end

  def create_account_link
    page_url = session[:page_url]       
    user = User.first                   # Users are not dynamic in this demo
    if user.stripe_id.present?
      account_link = Stripe::AccountLink.create({
        account: user.stripe_id,
        refresh_url: page_url,
        return_url: page_url,
        type: "account_onboarding",
      })
      redirect_to account_link.url      # redirect to stripe provided url
    end
  end
end
