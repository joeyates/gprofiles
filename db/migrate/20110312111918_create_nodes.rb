class CreateNodes < ActiveRecord::Migration

  def self.up
    create_table :nodes do |t|
      t.integer :nid,       :null => false
      t.integer :pid
      t.text    :label
      t.float   :weight
      t.integer :parent_id, :null => true
    end

    add_index :nodes, :nid
    add_index :nodes, :parent_id
  end

  def self.down
    drop_table :nodes
  end

end
