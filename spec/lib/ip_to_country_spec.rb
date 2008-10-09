require 'rubygems'
require 'spec'
require File.dirname(__FILE__) + '/../../lib/ip_to_country'

describe IpToCountry do
  describe "country_of 122.53.210.248" do
    it "should be PH" do
      IpToCountry.country_of( "122.53.210.248" ).should == 'PH'
    end
  end
  
  describe "country_of 208.78.102.228" do
    it "should be US" do
      IpToCountry.country_of( "208.78.102.228" ).should == 'US'
    end
  end
  
  describe "country_of 121.254.166.40" do
    it "should be KR" do
      IpToCountry.country_of( "121.254.166.40" ).should == 'KR'
    end
  end
end

