class AdminController < ApplicationController
  def index
  end

  def auth
	session[:valid] = params[:pass] == "ax3" 
  	render :json => { :valid => session[:valid] }
  end

  def start
  	puts "redirecting"
  	$setVote.call "test", ["a", "b"]
  	render :json => { :started => true }
  end
end
