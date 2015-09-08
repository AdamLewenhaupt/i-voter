class CreatePollOptions < ActiveRecord::Migration
  def change
    create_table :poll_options do |t|
    	t.belongs_to :poll
    	t.string :description
      t.timestamps
    end
  end
end
