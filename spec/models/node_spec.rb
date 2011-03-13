require File.dirname( __FILE__ ) + '/../spec_helper'

describe Node do

  fixtures :all

  before :each do
    @profile = profiles( :basic )
  end

  it "should have a parent" do
    pending
  end

  it "should have children" do
    pending
  end

  it "should allow parent to be missing" do
    pending
  end

  it "should have parents" do
    node = nodes( :with_parents )

    node.parents.size.     should       == 2
  end

  it "should supply info" do
    pending
  end

end
