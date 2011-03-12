class NodesController < ApplicationController

  def index
    @node = Node.find( 1 )
    render :action => :show
  end

  def show
    nid = params[ :id ].to_i
    @node = Node.find( nid )
  end

end
