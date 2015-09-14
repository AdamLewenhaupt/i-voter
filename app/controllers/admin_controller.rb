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

        redirect_to "/vote/start"
    end

    def stop
        $voting = false
        redirect_to "/vote/stop"
    end

    def update_location

        $LAT = params[:latitude].to_f
        $LONG = params[:longitude].to_f

        render :json => { :update => true }
    end
end
