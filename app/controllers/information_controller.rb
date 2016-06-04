require "krist"

class InformationController < ApplicationController

  def index
    redirect_to "/info" if session[:password]
  end

  def post
    session[:password] = params[:password]
    redirect_to "/info"
  end

  def show
    #(1).upto(20) do |x| puts session[:password].nil? end
    redirect_to "/" if session[:password].nil?
    if(!session[:password].nil?) then
      @wallet = KWalletClient.new(session[:password])
      info = @wallet.getInfo["address"]
      puts info["balance"]
      @balance = info["balance"]
      @firstseen = info["firstseen"]
      @totalin = info["totalin"]
      @totalout = info["totalout"]
      domains = @wallet.getDomains
      @totaldomains = domains["total"]
      @domains = ""
      domains["names"].each do |domain|
        @domains += "#{domain['name']} "
      end
    end

  end

  def logout
    session[:password] = nil
    redirect_to "/"
  end

end
