class AccountsController < ApplicationController
  def new
    @account = Account.new
  end

  def create
    @account = Account.new(account_params)
 
    if @account.save
      redirect_to @account, notice: "Account successfully created"
    else
      render "new"
    end
  end

  private
  def account_params
    params.require(:account).permit(:email)
  end
end
