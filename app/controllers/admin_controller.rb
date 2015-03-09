class AdminController < ApplicationController
  def index
  end

  def auth
	session[:valid] = params[:pass] == "ax3" 
  	render :json => { :valid => session[:valid] }
  end
end
