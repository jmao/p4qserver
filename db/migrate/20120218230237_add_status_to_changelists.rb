class AddStatusToChangelists < ActiveRecord::Migration
  def change
    add_column :changelists, :status, :string, :default => 'new'
  end
end
