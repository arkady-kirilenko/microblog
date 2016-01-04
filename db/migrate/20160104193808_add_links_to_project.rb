class AddLinksToProject < ActiveRecord::Migration
  def change
    add_column :projects, :project_url, :string
    add_column :projects, :github_url, :string
  end
end
