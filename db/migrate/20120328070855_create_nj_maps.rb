class CreateNjMaps < ActiveRecord::Migration
  def change
    create_table :nj_maps do |t|
      t.string :mapname

      t.timestamps
    end
  end
end
