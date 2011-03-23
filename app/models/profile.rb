class Profile < ActiveRecord::Base
  has_many :nodes
  has_attached_file :gprof

  #validates_attachment_presence

  def parse!
    raw = File.read( gprof.path )
    nodes = parse_raw( raw )
    set_parent( nodes )
    self
  end

  def root
    nodes.order( 'id' ).first
  end

  private

  def parse_raw( raw )
    nodes = []
    each_chunk( raw ) do | chunk |
      nodes << Node.parse( self, chunk )
    end
    nodes
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

  def set_parent( nodes )
    nodes.each do | node |
      node.pids.each do | pid |
        parent = self.nodes.find_by_nid( pid )
        if parent
          node.parents << parent
        end
      end
    end
  end

end
