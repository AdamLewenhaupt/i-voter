class AdminController < ApplicationController
  def index
  end

  def auth
	session[:valid] = params[:pass] == "ax3" 
  	render :json => { :valid => session[:valid] }
  end

  def start

    $voteOptions = params[:options]

  	$setVote.call $voteOptions
  	render :json => { :started => true }
  end
end
