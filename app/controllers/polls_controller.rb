class PollsController < ApplicationController
	before_filter :authenticate_user!

	def show
		@poll = Poll.find(params[:id])

		respond_to do |format|
			format.html {render text: @poll.subject}
			format.json {render json: @poll.to_json(include: :poll_options)}
		end
	end

	def new
		@poll = Poll.new
		render :new
	end

	def create
		@poll = Poll.new(poll_params)

		if @poll.valid?
			@poll.save!

			respond_to do |format|
				format.html {render text: "Klart!"}
				format.json {render json: @poll}
			end
		else
			respond_to do |format|
				format.html {render :new and return}
				format.json {render json: @poll.errors, status: :bad_request}
			end
		end
	end

	def latest
		@poll = Poll.order("created_at").last
		redirect_to poll_path(@poll)
	end

	def open
		@poll = Poll.find(params[:id])
		@poll.open = true
		@poll.save

		respond_to do |format|
			format.html {render text: @poll.subject}
			format.json {render json: @poll}
		end
	end

	def close
		@poll = Poll.find(params[:id])
		@poll.open = false
		@poll.save
		
		respond_to do |format|
			format.html {render text: @poll.subject}
			format.json {render json: @poll}
		end
	end

	private

	def poll_params
		params.require(:poll).permit(:subject)
	end
end