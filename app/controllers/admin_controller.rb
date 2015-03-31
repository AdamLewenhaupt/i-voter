class AdminController < ApplicationController
  def index
  end

  def auth
	session[:valid] = params[:pass] == "ax3" 
  	render :json => { :valid => session[:valid] }
  end

  def start

    $voteOptions = params[:options]
    $voteCounter = Hash[$voteOptions.map { |e| [e,0] }]

    $voting = true

  	# $setVote.call $voteOptions
  	render :json => { :started => true }
  end

  def end
    $voting = false
    # $stopVote.call
    render :json => { :stopped => true }
  end
end
