# -*- coding: utf-8 -*-
class ProfilesController < ApplicationController

  def index
    @profiles = Profile.all
  end

  def show
    @profile = Profile.find( params[ :id ] )
  end

  def new
    @profile = Profile.new
  end

  def create
    gprof    = params[ :profile ].delete( :gprof )
    @profile = Profile.create!( params[ :profile ] )
    @profile.parse!( gprof )
    redirect_to profile_url( @profile )
  end

  def edit
    @profile = Profile.find( params[ :id ] )
  end

  def update
    gprof    = params[ :profile ].delete( :gprof )
    @profile = Profile.find( params[ :id ] )
    @profile.update_attributes( params[ :profile ] )
    @profile.nodes.delete_all
    @profile.parse!( gprof )

    redirect_to profile_url( @profile )
  end

end
