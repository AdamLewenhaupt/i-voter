class VoteController < WebsocketRails::BaseController
    before_filter :authenticate_user!

    def initialize_session
        controller_store[:user_check] = []
        controller_store[:voting] = false
        controller_store[:vote_options] = nil
        controller_store[:vote_counter] = nil
    end

    def init
        puts current_user['username']
        if message["admin"]
            puts "works.."
            send_message :i, { 
                :options => controller_store[:vote_options], 
                :stats => controller_store[:vote_counter] 
            }
        else
            send_message :i, { 
                :options => controller_store[:vote_options].join('|'),
                :voted => controller_store[:user_check].include?(current_user['username']) 
            }
        end
    end

    def vote
        # if not controller_store[:user_check].include? current_user["username"]
        if true
            id = message["id"].to_i
            controller_store[:user_check].push current_user["username"]
            controller_store[:vote_counter][id] += 1
            broadcast_message :u, { :id => id }
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
