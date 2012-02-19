class AddBranchesToChangelists < ActiveRecord::Migration
  def change
    add_column :changelists, :branches, :integer
  end
end
