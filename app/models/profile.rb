class Profile < ActiveRecord::Base
  has_many :nodes

  def self.import( path_name )
    profile = Profile.create!( :path_name => path_name )
    profile.parse!
  end

  def parse!
    raw = File.read( path_name )
    parse_raw( raw )
    set_parent
    self
  end

  private

  def parse_raw( raw )
    each_chunk( raw ) do | chunk |
      Node.parse( self, chunk )
    end
  end

  def each_chunk( raw )
    # skip to the first entry
    start = raw.match( /index\s+%\s+time\s+self.*\n/ )
    raise "start not found" if start.nil?
    rest  = start.post_match
    lines = rest.split(/^-{10,}/)
    lines.pop # lose the doc page and index
    lines.each do | line |
      yield line
    end
  end

  def set_parent
    self.nodes.each do | node |
      node.pids.each do | pid |
        parent = self.nodes.find_by_nid( pid )
        if parent
          node.parents << parent
        end
      end
    end
  end

end
