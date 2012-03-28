class CreateNjClasses < ActiveRecord::Migration
  def change
    create_table :nj_classes do |t|
      t.int :classid
      t.string :classname

      t.timestamps
    end
  end
end
