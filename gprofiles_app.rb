GProfilesRoot = File.dirname( __FILE__ )
$:.unshift( GProfilesRoot )
require 'rubygems' if RUBY_VERSION < '1.9'

require 'sinatra/base'
require 'haml'
require 'dm-core'
require 'data_mapper'
require 'models/node'
require 'models/profile'

DataMapper.setup( :default, "sqlite3://#{ GProfilesRoot }/gprofiles.sqlite3" )
DataMapper.finalize

class GProfilesApp < Sinatra::Base
  set :public, File.dirname( __FILE__ ) + '/static'

  $prof = Profile.new( 'active_record.gprof' )

  get '/' do
    @node = $prof.nodes[ 1 ]
    haml :node
  end

  get '/:nid' do
    nid = params[ :nid ].to_i
    @node = $prof.nodes[ nid ]
    haml :node
  end

end
