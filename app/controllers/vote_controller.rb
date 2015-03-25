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

		filter :in do 

			msg = message["data"]
			if msg != nil
				data = msg.split ':'
				if data[0] == "vote"
					id = data[1]
					puts "works #{id}"
				end
			end

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