class CreatePolls < ActiveRecord::Migration
  def change
    create_table :polls do |t|
    	t.string :subject
      t.timestamps
    end
  end
end
