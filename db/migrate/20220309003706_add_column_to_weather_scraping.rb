class AddColumnToWeatherScraping < ActiveRecord::Migration[6.0]
  def change
    add_column :weather_scrapings, :target1, :integer
    add_column :weather_scrapings, :target2, :integer
    add_column :weather_scrapings, :target3, :integer
    add_column :weather_scrapings, :target4, :integer
    add_column :weather_scrapings, :target5, :integer
  end
end
