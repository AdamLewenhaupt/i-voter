class PollOption < ActiveRecord::Base
	belongs_to :poll

	after_initialize do
		votes ||= 0
	end

	def vote(user)
		return false if poll.open == false

		existing = UserPoll.where(user: user, poll: poll).count > 0
		return false if existing

		transaction do
			UserPoll.create!(user: user, poll: poll)
			self.votes = (votes || 0) + 1
			save!
		end

		true
	end
end
