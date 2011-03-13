require File.dirname( __FILE__ ) + '/../spec_helper'

describe Node do

  fixtures :all

  before :each do
    @profile = profiles( :basic )
  end

  context :parsing do

    it "should parse chunks" do
      node = Node.parse( @profile, chunk )

      node.nid.          should    == 4
      node.pids.         should    == [ 138, 3 ]
      node.weight.       should    == 24.8
      node.label.        should    == 'ActiveRecord::Connection::select_all(std::string const&, std::list<ActiveRecord::Attribute, std::allocator<ActiveRecord::Attribute> > const&)'
    end

    it "should raise an error when the root line is not found" do
      no_root = chunk.gsub( /^\[\d+\] /, 'xxx' )

      expect do
        Node.parse( @profile, no_root )
      end.to raise_error( RuntimeError, /root line not found/ )
    end

  end

  context :attributes do
    it "should supply info" do
      node = nodes( :root )

      node.info.     should      == 'root (95.0%)'
    end
  end

  context :relationships do

    it "can have parents" do
      node = nodes( :with_parents )

      node.parents.size.     should       == 2
      node.parents[ 0 ].     should       == nodes( :root )
      node.parents[ 1 ].     should       == nodes( :intermediate_a )
    end

    it "can have no parents" do
      node = nodes( :root )

      node.parents.size.     should       == 0
    end

    it "should have children" do
      node = nodes( :root )

      node.children.size.     should       == 2
      node.children[ 0 ].     should       == nodes( :intermediate_a )
      node.children[ 1 ].     should       == nodes( :with_parents )
    end

  end

  def chunk
    <<EOT
                0.00    0.00       1/100001      ActiveRecord::Connection::table_exists(std::string const&) [138]
                0.02    0.12  100000/100001      ActiveRecord::Query<Greeting>::all() [3]
[4]     24.8    0.02    0.12  100001         ActiveRecord::Connection::select_all(std::string const&, std::list<ActiveRecord::Attribute, std::allocator<ActiveRecord::Attribute> > const&) [4]
                0.01    0.05  200000/200000      ActiveRecord::Row::Row(sqlite3_stmt*) [13]
                0.00    0.02  200000/200000      std::list<ActiveRecord::Row, std::allocator<ActiveRecord::Row> >::push_back(ActiveRecord::Row const&) [47]
                0.00    0.01  200000/400000      ActiveRecord::Row::~Row() [45]
                0.00    0.01  100001/100001      std::list<ActiveRecord::Row, std::allocator<ActiveRecord::Row> >::list() [105]
                0.00    0.00  100001/100004      ActiveRecord::Connection::prepare(std::string const&, std::list<ActiveRecord::Attribute, std::allocator<ActiveRecord::Attribute> > const&) [167]
EOT
  end

end
