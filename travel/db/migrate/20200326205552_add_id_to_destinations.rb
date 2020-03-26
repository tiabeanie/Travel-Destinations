class AddIdToDestinations < ActiveRecord::Migration
  def change
    add_column :destinations, :user_id, :integer
  end
end
