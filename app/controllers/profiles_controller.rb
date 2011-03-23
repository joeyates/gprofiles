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
    @profile = Profile.create!( params[ :profile ] )
    @profile.parse!
    redirect_to profile_url( @profile )
  end

  def edit
    @profile = Profile.find( params[ :id ] )
  end

  def update
    @profile = Profile.find( params[ :id ] )
    @profile.nodes.delete_all
    @profile.parse!
    @profile.update_attributes( params[ :profile ] )
    redirect_to profile_url( @profile )
  end

end
