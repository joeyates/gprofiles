class Node < ActiveRecord::Base
  belongs_to :parent, :class_name => 'Node'
  has_many   :children, :class_name => 'Node', :foreign_key => :parent_id

  validates_presence_of :profile_id
  validates_presence_of :label
  validates_presence_of :weight
  validates_uniqueness_of :nid, :scope => :profile_id

  def Node.parse( profile, chunk )
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

    Node.create!( :nid        => nid,
                  :pid        => pid,
                  :weight     => weight,
                  :label      => label,
                  :profile_id => profile.id)
  end

  def info
    "#{ label } (#{ weight }%)"
  end

end
