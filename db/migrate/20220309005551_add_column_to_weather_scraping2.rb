class AddColumnToWeatherScraping2 < ActiveRecord::Migration[6.0]
  def change
    add_column :weather_scrapings, :accum, :float, null: false ,default: 0
  end
end
