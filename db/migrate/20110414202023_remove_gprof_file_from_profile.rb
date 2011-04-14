class RemoveGprofFileFromProfile < ActiveRecord::Migration

  def self.up
    remove_column :profiles, :gprof_file_name
  end

  def self.down
    add_column :profiles, :gprof_file_name,    :string
  end

end
