require 'fitocracy/login'
require 'fitocracy/user'
require 'mechanize'
require 'spec_helper'

module Fitocracy
  describe User do
    describe "initial login" do
      it "should work with a valid login" do
        @user = User.new(:username => "mwotton_api", :password => "password")
        @user.x_fitocracy_user.should == '1399037'
      end

      it "should fail with an invalid login" do
        expect {
          @user = User.new(:username => "not_mwotton_api", :password => "password")}.to raise_error
      end
    end

    describe "operations" do
      before do
        @valid_user = User.new(:username => "mwotton_api", :password => "password")
      end

      it "activities" do
        @valid_user.activities.should == [{"count"=>1, "id"=>761, "name"=>"Bench Press Lockout"}]

      end
    end
  end
end
