require 'cpp_method'

class Node < ActiveRecord::Base
  has_and_belongs_to_many :parents, :join_table              => :relationships,
                                    :class_name              => 'Node',
                                    :foreign_key             => :child_id,
                                    :association_foreign_key => :parent_id
  has_and_belongs_to_many :children, :join_table              => :relationships,
                                     :class_name              => 'Node',
                                     :foreign_key             => :parent_id,
                                     :association_foreign_key => :child_id

  belongs_to :profile

  attr_accessor :pids

  validates_presence_of :nid
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
    label    = 'main()' if label == 'main'

    pids = []
    while m = start.match( /\[(\d+)\]$/ )
      pids << m[ 1 ].to_i
      start = m.post_match
    end

    Node.create!( :nid        => nid,
                  :pids       => pids,
                  :weight     => weight,
                  :label      => label,
                  :profile_id => profile.id)
  end

  def info
    ( ! method.class_name.blank? ? "#{ method.class_name }::" : '' ) + "#{ method.method }() (#{ weight }%)"
  end

  def method
    @method ||= CppMethod.new( label )
  end

end
