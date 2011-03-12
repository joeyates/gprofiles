class CreateProfiles < ActiveRecord::Migration
  def self.up
    create_table :profiles do | t |
      t.string :path_name

      t.timestamps
    end

    add_column :nodes, :profile_id, :integer
  end

  def self.down
    remove_column :nodes, :profile_id
    drop_table :profiles
  end
end
