class NodesController < ApplicationController

  def show
    @profile = Profile.find( params[ :profile_id ] )
    @node    = @profile.nodes.find( params[ :id ] )
  end

end
