class AddUrlToReel < ActiveRecord::Migration[7.0]
  def change
    add_column :reels, :url, :string
  end
end
