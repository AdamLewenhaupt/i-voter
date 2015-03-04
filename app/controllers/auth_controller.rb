class AuthController < ApplicationController

	def verify 

		puts "dist: #{params[:dist]}"

		@dist = params[:dist].to_f
		@acc = params[:acc].to_f

		@safeZone = 500

		if @acc <= @safeZone / 2
			@auth = @dist - @acc <= @safeZone
		else
			@auth = false  
		end

		render :json => { :auth => @auth }
	end
end
