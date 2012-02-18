class CreateChangelists < ActiveRecord::Migration
  def change
    drop_table :changelists
    create_table :changelists do |t|
      t.string :p4number

      t.timestamps
    end
  end
end
