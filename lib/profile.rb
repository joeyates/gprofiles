class Profile

  attr_reader :nodes

  def initialize( path_name )
    @path_name = path_name
    parse
  end

  private

  def parse
    raw = File.read( @path_name )
    parse_raw( raw )
    set_parent
  end

  def parse_raw( raw )
    @nodes = []
    each_chunk( raw ) do | chunk |
      node              = Node.parse( chunk )
      @nodes[ node.nid ] = node
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
    @nodes.each.with_index do | node, i |
      if node
        if node.pid
          parent      = nodes[ node.pid ]
          node.parent = parent
          if parent
            parent.children << node
          else
            $stderr.puts "Parent missing: #{ node.pid }"
          end
        else
          $stderr.puts "No parent: #{ i }"
        end
      else
        $stderr.puts "No node: #{ i }"
      end
    end
  end

end
