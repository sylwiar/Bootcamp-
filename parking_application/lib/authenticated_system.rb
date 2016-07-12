# -*- encoding : utf-8 -*-

class AuthenticationError < StandardError; end

module AuthenticatedSystem
  def self.included(base)
    base.send :helper_method, :current_user, :current_account, :account_signed_in? if base.respond_to? :helper_method
  end

  protected

  # return current logged in person
  def current_user
  end

  # return current logged in account
  def current_account
  end

  # set session account_id and current_account instance variable
  def current_account=(new_account)
  end

  # set current_account using session
  def login_from_session
  end

  # check if user is logged in
  def account_signed_in?
  end

  # return current login status (boolean value) or redirect to login form and save current user location
  def authenticate_account!
  end

  # save current user location and redirect to login form
  def access_denied
  end

  # save current user location in session[:return_to]
  def store_location
  end

  # redirect to stored URL or default path
  def redirect_back_or_default(default)
  end

  # clear session account_id and current_account variable
  def logout!
  end
end