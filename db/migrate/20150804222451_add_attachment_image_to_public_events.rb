class AddAttachmentImageToPublicEvents < ActiveRecord::Migration
  def self.up
    change_table :public_events do |t|
      t.attachment :image
    end
  end

  def self.down
    remove_attachment :public_events, :image
  end
end
