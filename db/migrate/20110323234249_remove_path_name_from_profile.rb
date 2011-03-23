class RemovePathNameFromProfile < ActiveRecord::Migration

  def self.up
    remove_column :profiles, :path_name
  end

  def self.down
    add_column :profiles, :path_name
  end

end
