class CreateScrapers < ActiveRecord::Migration[5.2]
  def change
    create_table :scrapers do |t|
      t.string :keyword
      t.string :limit
      t.string :device

      t.timestamps
    end
  end
end
