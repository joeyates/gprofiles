class CreateNodes < ActiveRecord::Migration

  def self.up
    create_table :nodes do |t|
      t.integer :nid,       :null => false
      t.text    :label
      t.float   :weight
    end
  end

  def self.down
    drop_table :nodes
  end

end
