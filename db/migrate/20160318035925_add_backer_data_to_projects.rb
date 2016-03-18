class AddBackerDataToProjects < ActiveRecord::Migration
  def change
    add_column :projects, :raised, :integer
    add_column :projects, :backers, :integer
  end
end
