class AddAttachmentBannerToProjects < ActiveRecord::Migration
  def self.up
    change_table :projects do |t|
      t.attachment :banner
    end
  end

  def self.down
    remove_attachment :projects, :banner
  end
end
