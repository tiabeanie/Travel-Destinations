class AddIdToDestinations < ActiveRecord::Migration
  def change
    add_column :destinations, :email, :integer
  end
end
