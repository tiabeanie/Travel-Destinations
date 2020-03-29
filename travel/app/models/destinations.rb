class Destination < ActiveRecord::Base
  belongs_to :user
  belongs_to :country

  def self.create_new_destination(description, session_uid)
    @description = description
    @user = User.find(session_uid)

    set_country

    @destination = Destination.new(
      :description => @description[:description],
      :country => @country,
    )

    @destination.save
    @destination
  end

  def self.update_destination(description, destination)
    @description = description
    @destination = destination

    set_country

    @destination.update(
      :description => @description[:description],
      :country => @country
    )

    @destination.save
    @destination
  end

  def self.set_country
    @country = Country.find_by(:name => @description[:country]).presence || Country.create(:name => @description[:country])
  end
end