class CreateBeepTimestamps < ActiveRecord::Migration[7.2]
  def change
    create_table :beep_timestamps do |t|
      t.references :habit, null: false, foreign_key: true
      t.string :video_id
      t.json :timestamps
      t.string :status

      t.timestamps
    end
  end
end
