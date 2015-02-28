class VoteController < FayeRails::Controller
	channel '/vote' do
		monitor :subscribe do
			puts "Client #{client_id} subscribed to #{channel}"
		end
	end
end