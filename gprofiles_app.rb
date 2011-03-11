require 'rubygems' if RUBY_VERSION < '1.9'
$:.unshift( '.' )

require 'sinatra/base'
require 'helpers/node_helpers'
require 'models/node'
require 'models/profile'

class GProfilesApp < Sinatra::Base

  $prof = Profile.new( 'active_record.gprof' )

  get '/' do
    $prof.nodes[ 1 ].render
  end

  get '/:nid' do
    nid = params[ :nid ].to_i
    $prof.nodes[ nid ].render
  end

end
