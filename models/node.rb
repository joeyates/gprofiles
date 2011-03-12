class Node
  include DataMapper::Resource

  property :id,        Serial
  property :parent_id, Integer, :key => true, :required => false
  property :label,     String
  property :weight,    Float

  belongs_to :node
  has n,     :children, :child_key => [ :parent_id ]

  def Node.parse( chunk )
    #          1         2                3           4            5 = rest
    #          id        time             self        children     called   name
    rgx = /^\[(\d+)\]\s+(\d+\.\d+)\s{4}(\d+\.\d+)\s{4}(\d+\.\d+)\s+(.*)$/
    m = chunk.match( rgx )
    raise "root line not found in '#{ chunk }'" if m.nil?
    start     = m.pre_match
    nid       = m[ 1 ].to_i
    weight    = m[ 2 ].to_f
    rest      = m[ 5 ]

    # strip call count
    rest.gsub!( /^\d+(\/\d+)?\s+/, '' )
    m        = rest.match( /^(.*?)\s+\[\d+\]$/ )
    raise "unexpected rest format: #{ rest }" if m.nil?
    label    = m[ 1 ]

    m        = start.match( /\[(\d+)\]$/ )
    pid      = m[ 1 ].to_i unless m.nil?

    node = Node.new( :id        => nid,
                     :weight    => weight,
                     :label     => label,
                     :parent_id => pid )
    node.save
  end

  def info
    "#{ @label } (#{ @weight }%)"
  end

  def link_to
    "<a href='/#{ @nid }'>#{ info }</a>"
  end

end
