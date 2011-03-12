require 'rubygems' if RUBY_VERSION < '1.9'
$:.unshift( File.dirname( __FILE__ ) )

require 'sinatra/base'
require 'haml'
require 'helpers/node_helpers'
require 'models/node'
require 'models/profile'

class GProfilesApp < Sinatra::Base
  include NodeHelpers

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
