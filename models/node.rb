class Node
  include NodeHelpers

  attr_accessor :nid
  attr_accessor :pid
  attr_accessor :parent
  attr_accessor :label
  attr_accessor :weight
  attr_accessor :children

  def initialize( chunk )
    @nid       = nil
    @pid       = nil
    @parent    = nil
    @label     = ''
    @children  = []
    @weight    = 0.0
    parse( chunk )
  end

  def info
    "#{ @label } (#{ @weight }%)"
  end

  private

  def parse( chunk )
    #          1         2                3           4            5 = rest
    #          id        time             self        children     called   name
    rgx = /^\[(\d+)\]\s+(\d+\.\d+)\s{4}(\d+\.\d+)\s{4}(\d+\.\d+)\s+(.*)$/
    m = chunk.match( rgx )
    raise "root line not found in '#{ chunk }'" if m.nil?
    start     = m.pre_match
    @nid      = m[ 1 ].to_i
    @weight   = m[ 2 ].to_f
    rest      = m[ 5 ]

    # strip call count
    rest.gsub!( /^\d+(\/\d+)?\s+/, '' )
    m        = rest.match( /^(.*?)\s+\[\d+\]$/ )
    raise "unexpected rest format: #{ rest }" if m.nil?
    @label   = m[ 1 ]

    m        = start.match( /\[(\d+)\]$/ )
    @pid     = m[ 1 ].to_i unless m.nil?
  end

end
