class PollOptionsController < ApplicationController
	before_filter :authenticate_user!

	def show
		@poll = Poll.find(params[:poll_id])

		respond_to do |format|
			format.html {render text: @poll.subject}
			format.json {render json: @poll}
		end
	end

	def new
		@poll = Poll.find(params[:poll_id])
		@option = @poll.poll_options.new
		render :new
	end

	def create
		@poll = Poll.find(params[:poll_id])
		@option = @poll.poll_options.new

		if @option.valid?
			@option.save!

			respond_to do |format|
				format.html {render text: "Klart!"}
				format.json {render json: @poll}
			end
		else
			respond_to do |format|
				format.html {render :new and return}
				format.json {render json: @option.errors, status: :bad_request}
			end
		end
	end

	def vote
		poll = Poll.find(params[:poll_id])
		option = poll.poll_options.find(params[:id])
		user = current_user

		if option.vote(user)
			render text: "Klart!", status: 201
		else
			render text: "Redan röstat?", status: 400
		end
	end

	private

	def poll_params
		params.require(:poll_option).permit(:description)
	end
end