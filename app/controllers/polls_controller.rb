class PollsController < ApplicationController
	def new
		@poll = Poll.new
		render :new
	end
end
