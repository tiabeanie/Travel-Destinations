class AddUserIdToGolfBags < ActiveRecord::Migration
    def change
      add_column :destinations, :user_id, :integer
    end
  end