class VoteController < FayeRails::Controller

	voters = 0

	channel '/vote' do
		monitor :subscribe do
			voters += 1
			VoteController.publish('/vote', "count:#{voters}")
		end

		monitor :unsubscribe do
			voters -= 1
			VoteController.publish('/vote', "count:#{voters}")
		end
	end

	$setVote = lambda do |options|
		opts = options.join '|'
		VoteController.publish('/vote', "start:#{opts}")
	end

	$stopVote = lambda do 
		VoteController.publish('/vote', "end")
	end
end