class TransactionsController < ApplicationController

  def post
    redirect_to "/transaction"
  end

  def show
    @wallet = KWalletClient.new(session[:password])
    @balance = @wallet.getInfo["address"]["balance"]
  end

  def put
    @wallet = KWalletClient.new(session[:password])
    @wallet.sendTo(to: params["to"], amount: params["amount"], metadata: "Sent with Reinboo")
    redirect_to "/info"
  end

end
