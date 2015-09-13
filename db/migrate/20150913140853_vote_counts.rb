class VoteCounts < ActiveRecord::Migration
  def change
  	change_table :poll_options do |p|
  		p.integer :votes
  	end
  end
end
