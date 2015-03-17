class AdminController < ApplicationController
  def index
  end

  def auth
	session[:valid] = params[:pass] == "ax3" 
  	render :json => { :valid => session[:valid] }
  end

  def start

    $voteOptions = params[:options]
    $voting = true

  	$setVote.call $voteOptions
  	render :json => { :started => true }
  end

  def stop
    $voting = false
    $stopVote.call
    render :json => { :stopped => true }
  end
end
