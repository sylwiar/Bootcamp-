class SessionsController < ApplicationController
  def new
    account = Account.new
  end

  def create
    account = Account.authenticate(params[:email], params[:password])
    if account
      session[:account_id] = account.id
      flash[:success] = "You have been logged in."
      redirect_to(session[:return_to] || root_url)
    else
      flash[:error] = "Email or password is invalid"
      render "new"
    end
  end

  def destroy
    session[:account_id] = nil
    session[:account_type] = nil
    reset_session
    redirect_to root_url, flash: { success: "Logged out." }
  end
end