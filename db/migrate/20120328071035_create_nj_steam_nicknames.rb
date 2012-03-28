class CreateNjSteamNicknames < ActiveRecord::Migration
  def change
    create_table :nj_steam_nicknames do |t|
      t.references :nj_steamid
      t.string :nickname

      t.timestamps
    end
    add_index :nj_steam_nicknames, :nj_steamid_id
  end
end
