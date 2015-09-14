class VoteController < FayeRails::Controller

    channel '/vote' do
        # monitor :subscribe do
        # 	voters += 1
        # 	VoteController.publish('/vote', "count:#{voters}")
        # end

        # monitor :unsubscribe do
        # 	voters -= 1
        # 	VoteController.publish('/vote', "count:#{voters}")
        # end

        monitor :publish do 
            msg = data.inspect
            if msg != nil

                parts = msg.delete('"').split ":"
                if parts[0] == "vote"
                    user = parts[1]
                    if not $userChecker.include? user
                        id = parts[2].to_i
                        $userChecker.push user                   
                        $voteCounter[$voteOptions[id]] += 1
                    end

                elsif parts[0] == "start"
                    options = parts[1].split '|'
                    $userChecker = []
                    $voting = true
                    $voteOptions = options
                    $voteCounter = Hash[$voteOptions.map { |e| [e,0] }]

                elsif parts[0] == "end"
                    puts "Ending vote"
                    $voting = false
                end
            end
        end
    end

    def start
        puts "hello"
        opts = params[:options].join '|'
        VoteController.publish('/vote', "start:#{opts}")
        render :json => { :started => true }
    end

    def stop 
        VoteController.publish('/vote', "end")
        render :json => { :stopped => true }
    end


end
