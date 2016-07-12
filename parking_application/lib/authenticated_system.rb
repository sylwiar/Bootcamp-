# -*- encoding : utf-8 -*-

class AuthenticationError < StandardError; end

module AuthenticatedSystem
  def self.included(base)
    base.send :helper_method, :current_user, :current_account, :account_signed_in? if base.respond_to? :helper_method
  end

  protected

  # return current logged in person
  def current_user
    @current_user ||= (session[:person] && Person.find_by_id(session[:person])) || :false
  end

  # return current logged in account
  def current_account
    @current_account ||= (session[:account] && Account.find_by_id(session[:account])) || :false
  end

  # set session account_id and current_account instance variable
  def current_account=(new_account)
    session[:account] = (new_account.nil? || new_account.is_a?(Symbol)) ? nil : new_account.id
    @current_account = new_account
  end

  # set current_account using session
  def login_from_session
    self.current_account = Account.find_by_id(session[:account_id]) if session[:account_id]
  end

  # check if user is logged in
  def account_signed_in?
    current_user != :false
  end

  # return current login status (boolean value) or redirect to login form and save current user location
  def authenticate_account!
    return if @current_user
    session[:authenticate_uri] = request.request_uri
    redirect_to('/login')
  end

  # save current user location and redirect to login form
  def access_denied
    respond_to do |format|
      format.html do
        store_location
        redirect_to new_session_path
      end
      format.any do
        request_http_basic_authentication 'Web Password'
      end
    end
  end

  # save current user location in session[:return_to]
  def store_location
    session[:return_to] = request.fullpath
  end

  # redirect to stored URL or default path
  def redirect_back_or_default(default)
    redirect_to(session[:return_to] || default)
    session[:return_to] = nil
  end

  # clear session account_id and current_account variable
  def logout!
    self.current_account = nil
  end
end