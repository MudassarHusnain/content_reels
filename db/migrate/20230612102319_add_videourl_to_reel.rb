class AddVideourlToReel < ActiveRecord::Migration[7.0]
  def change
    add_column :reels, :video_urls, :string, default:""

  end
end
