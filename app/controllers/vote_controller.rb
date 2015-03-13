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

	$setVote = lambda do |name, options|
		opts = options.join '|'
		puts "starting vote: #{name}, options: #{opts}"
		VoteController.publish('/vote', "change:start:#{name}|#{opts}")
	end
end