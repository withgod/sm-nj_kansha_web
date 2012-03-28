class CreateNjKanshaResults < ActiveRecord::Migration
  def change
    create_table :nj_kansha_results do |t|
      t.integer :jump_count
      t.references :nj_steamid
      t.references :nj_map
      t.references :nj_class
      t.string :tags

      t.timestamps
    end
    add_index :nj_kansha_results, :nj_steamid_id
    add_index :nj_kansha_results, :nj_map_id
    add_index :nj_kansha_results, :nj_class_id
  end
end
