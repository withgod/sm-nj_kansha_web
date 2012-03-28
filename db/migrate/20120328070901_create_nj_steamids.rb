class CreateNjSteamids < ActiveRecord::Migration
  def change
    create_table :nj_steamids do |t|
      t.string :steamid
      t.int :steamcomid

      t.timestamps
    end
  end
end
