class CreateRelationships < ActiveRecord::Migration
  def self.up
    create_table( :relationships, :id => false ) do | t |
      t.integer :parent_id
      t.integer :child_id
    end

    add_index :relationships, :parent_id
    add_index :relationships, :child_id
  end

  def self.down
    drop_table :relationships
  end
end
