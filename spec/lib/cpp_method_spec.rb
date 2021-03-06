require File.dirname( __FILE__ ) + '/../spec_helper'
require 'cpp_method'

describe CppMethod do

  # '__gnu_cxx::__normal_iterator<char*, std::string> std::transform<__gnu_cxx::__normal_iterator<char*, std::string>, __gnu_cxx::__normal_iterator<char*, std::string>, int (*)(int)>(__gnu_cxx::__normal_iterator<char*, std::string>, __gnu_cxx::__normal_iterator<char*, std::string>, __gnu_cxx::__normal_iterator<char*, std::string>, int (*)(int))'

  it "should parse ctors" do
    s = 'ActiveRecord::Query<Greeting>::Query()'
    m = CppMethod.new( s )

    method_should( m,
                   'ActiveRecord', 'Query', [ 'Greeting' ],
                   'Query', [] )
  end

  it "should parse dtors" do
    s = 'std::_Rb_tree<std::string, std::pair<std::string const, ActiveRecord::Attribute>, std::_Select1st<std::pair<std::string const, ActiveRecord::Attribute> >, std::less<std::string>, std::allocator<std::pair<std::string const, ActiveRecord::Attribute> > >::~_Rb_tree()'
    m = CppMethod.new( s )

    method_should( m,
                   'std', '_Rb_tree', [ 'std::string, std::pair<std::string const, ActiveRecord::Attribute>, std::_Select1st<std::pair<std::string const, ActiveRecord::Attribute> >, std::less<std::string>, std::allocator<std::pair<std::string const, ActiveRecord::Attribute> >' ],
                   '~_Rb_tree', [] )
  end

  it "should parse class methods" do
    s = 'ActiveRecord::Connection::table_exists(std::string const&)'
    m = CppMethod.new( s )

    method_should( m,
                   'ActiveRecord', 'Connection', [],
                   'table_exists', [ 'std::string const&' ] )
  end

  it "should parse const methods" do
    s = 'std::vector<Greeting, std::allocator<Greeting> >::size() const'
    m = CppMethod.new( s )

    method_should( m,
                   'std', 'vector', [ 'Greeting, std::allocator<Greeting>' ],
                   'size', [] )
  end

  it "should parse functions" do
    s = 'ar_setup()'
    m = CppMethod.new( s )

    method_should( m,
                   '', '',  [],
                   'ar_setup', [] )
  end

  it "should parse functions with () in the parameter list" do
    s = 'boost::assign_detail::generic_list<std::pair<std::string, ActiveRecord::Attribute> >& boost::assign_detail::generic_list<std::pair<std::string, ActiveRecord::Attribute> >::operator()<char [6], char [6]>(char const (&) [6], char const (&) [6])'
    m = CppMethod.new( s )

    method_should( m,
                   'boost::assign_detail', 'generic_list',  [ 'std::pair<std::string, ActiveRecord::Attribute>' ],
                   'operator()', [ 'char const (&) [6], char const (&) [6]' ] )
  end

  def method_should( m, namespace, class_name, template_parameters, method, parameters )
    m.namespace.                   should      == namespace
    m.class_name.                  should      == class_name
    m.template_parameters.         should      == template_parameters
    m.method.                      should      == method
    m.parameters.                  should      == parameters
  end

end
