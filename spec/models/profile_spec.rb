require File.dirname( __FILE__ ) + '/../spec_helper'

describe Profile do

  fixtures :all

  before :all do
    @tf = Tempfile.new( "my.gprof" )
    @tf.write gprof_file
    @tf.close
  end

  after :all do
    @tf.open
    @tf.close( true )
  end

  it "should parse gprof output" do
    lambda do
      Profile.import( @tf.path )
    end.                        should_not  raise_error
  end

  it "should return new Profile from Profile.import" do
    profile = Profile.import( @tf.path )

    profile.is_a?( Profile ).   should   be_true
  end

  def gprof_file
    <<EOT
granularity: each sample hit covers 2 byte(s) for 1.82% of 0.55 seconds

index % time    self  children    called     name
                                                 <spontaneous>
[1]     91.8    0.00    0.51                 main [1]
                0.00    0.47       1/1           ar_query_retrieve() [2]
                0.00    0.04       1/1           ar_setup() [26]
                0.00    0.00       1/1           ar_close() [781]
-----------------------------------------------
                0.00    0.47       1/1           main [1]
[2]     85.5    0.00    0.47       1         ar_query_retrieve() [2]
                0.03    0.40  100000/100000      ActiveRecord::Query<Greeting>::all() [3]
                0.00    0.02  100000/100000      ActiveRecord::Query<Greeting>::~Query() [67]
                0.00    0.01  100000/100000      std::vector<Greeting, std::allocator<Greeting> >::~vector() [75]
                0.01    0.01  100000/100000      ActiveRecord::Query<Greeting>::Query() [107]
                0.00    0.00  100000/900000      std::vector<Greeting, std::allocator<Greeting> >::size() const [82]
-----------------------------------------------
                0.03    0.40  100000/100000      ar_query_retrieve() [2]
[3]     78.8    0.03    0.40  100000         ActiveRecord::Query<Greeting>::all() [3]
                0.02    0.12  100000/100001      ActiveRecord::Connection::select_all(std::string const&, std::list<ActiveRecord::Attribute, std::allocator<ActiveRecord::Attribute> > const&) [4]
                0.00    0.09  200000/200000      std::vector<Greeting, std::allocator<Greeting> >::push_back(Greeting const&) [6]
                0.00    0.05  200000/200000      ActiveRecord::Row::get_integer(std::string const&) [15]
                0.00    0.04  100000/100000      ActiveRecord::Query<Greeting>::query_and_parameters() [20]
                0.00    0.03  100000/100001      std::list<ActiveRecord::Row, std::allocator<ActiveRecord::Row> >::~list() [44]
                0.00    0.02  200000/500002      Greeting::~Greeting() [17]
                0.00    0.01  100000/100000      std::vector<Greeting, std::allocator<Greeting> >::vector() [111]
                0.00    0.01  300000/500000      std::list<ActiveRecord::Row, std::allocator<ActiveRecord::Row> >::end() [135]
                0.00    0.01  100000/200002      ActiveRecord::Connection::get_table(std::string const&) [133]
                0.00    0.00  100000/200000      std::pair<std::string, std::list<ActiveRecord::Attribute, std::allocator<ActiveRecord::Attribute> > >::~pair() [139]
                0.00    0.00  200000/200000      Greeting::Greeting(int) [169]
                0.00    0.00  100000/100000      std::list<ActiveRecord::Row, std::allocator<ActiveRecord::Row> >::begin() [172]
                0.00    0.00  300000/300000      std::_List_iterator<ActiveRecord::Row>::operator!=(std::_List_iterator<ActiveRecord::Row> const&) const [296]
                0.00    0.00  200000/200000      std::_List_iterator<ActiveRecord::Row>::operator->() const [347]
                0.00    0.00  200000/200000      std::_List_iterator<ActiveRecord::Row>::operator++() [357]
                0.00    0.00  100000/200003      ActiveRecord::Table::primary_key() const [317]
-----------------------------------------------
                0.00    0.00       1/100001      ActiveRecord::Connection::table_exists(std::string const&) [138]
                0.02    0.12  100000/100001      ActiveRecord::Query<Greeting>::all() [3]
[4]     24.8    0.02    0.12  100001         ActiveRecord::Connection::select_all(std::string const&, std::list<ActiveRecord::Attribute, std::allocator<ActiveRecord::Attribute> > const&) [4]
                0.01    0.05  200000/200000      ActiveRecord::Row::Row(sqlite3_stmt*) [13]
                0.00    0.02  200000/200000      std::list<ActiveRecord::Row, std::allocator<ActiveRecord::Row> >::push_back(ActiveRecord::Row const&) [47]
                0.00    0.01  200000/400000      ActiveRecord::Row::~Row() [45]
                0.00    0.01  100001/100001      std::list<ActiveRecord::Row, std::allocator<ActiveRecord::Row> >::list() [105]
                0.00    0.00  100001/100004      ActiveRecord::Connection::prepare(std::string const&, std::list<ActiveRecord::Attribute, std::allocator<ActiveRecord::Attribute> > const&) [167]
-----------------------------------------------
EOT
  end

end
