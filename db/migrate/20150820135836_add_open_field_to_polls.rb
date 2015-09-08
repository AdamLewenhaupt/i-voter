class AddOpenFieldToPolls < ActiveRecord::Migration
  def change
  	change_table :polls do |p|
  		p.boolean :open, default: false
  	end
  end
end
