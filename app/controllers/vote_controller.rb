class VoteController < WebsocketRails::BaseController

    def initialize_session
        controller_store[:user_check] = []
        controller_store[:voting] = false
        controller_store[:vote_options] = nil
        controller_store[:vote_counter] = nil
    end

    def init
        if controller_store[:vote_options] != nil
            puts controller_store[:vote_counter]
            if message["admin"]
                send_message :i, { :options => controller_store[:vote_options], :stats => controller_store[:vote_counter] }
            else
                send_message :i, { :options => controller_store[:vote_options].join('|') } 
            end
        end
    end

    def vote
        puts message
        if not $userChecker.include? message["user"]
            id = message["id"].to_i
            $userChecker.push message["user"]
            $voteCounter[id] += 1
        end
    end

    def start
        puts message["options"]
        controller_store[:voting] = true
        controller_store[:vote_options] = message["options"]
        controller_store[:vote_counter] = controller_store[:vote_options].map { |e| 0  }
        broadcast_message :start_vote, { :options => controller_store[:vote_options].join('|') }
    end

    def end 
        controller_store[:voting] = false
        send_message :end_vote, { :true => true }
        broadcast_message :x, { :true => true }
        controller_store[:vote_options] = nil
    end


end
