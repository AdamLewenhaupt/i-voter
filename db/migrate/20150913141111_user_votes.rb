class UserVotes < ActiveRecord::Migration
  def change
  	create_table :user_polls do |u|
  		u.references :user
  		u.references :poll
  	end
  end
end
