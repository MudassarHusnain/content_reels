class CreateReels < ActiveRecord::Migration[7.0]
  def change
    create_table :reels do |t|
      t.string :video_set
      t.string :keywords
      t.integer :no_of_video
      t.string :platform
      t.boolean :cta,default:false
      t.references :project, null: false, foreign_key: true

      t.timestamps
    end
  end
end
