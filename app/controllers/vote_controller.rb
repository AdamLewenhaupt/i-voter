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

		# monitor :publish do 
		# 	msg = data.inspect
		# 	if msg != nil

		# 		parts = msg.delete('"').split ":"
		# 		if parts[0] == "vote"
		# 			id = parts[1].to_i
		# 			$voteCounter[$voteOptions[id]] += 1
		# 			VoteController.publish '/vote', "admin:#{id}"
		# 		end
		# 	end
		# end
	end

	$setVote = lambda do |options|
		opts = options.join '|'
		VoteController.publish('/vote', "start:#{opts}")
	end

	$stopVote = lambda do 
		VoteController.publish('/vote', "end")
	end


end