class AddGprofFileToProfile < ActiveRecord::Migration

  def self.up
    add_column :profiles, :gprof_file_name,    :string
  end

  def self.down
    remove_column :profiles, :gprof_file_name
  end

end
