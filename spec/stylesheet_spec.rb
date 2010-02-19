require File.dirname(__FILE__) + '/spec_helper.rb'
require 'action_controller'
require 'action_view'
require 'my_amee/stylesheets'

describe ActionView::Helpers::AssetTagHelper do

  class TestView < ActionView::Base
    include ActionView::Helpers::AssetTagHelper
  end

  describe "without valid My AMEE config" do

    before :each do
      @view = TestView.new
      flexmock(MyAmee::AppConfig).should_receive(:get).with(:theme).and_return(nil)
    end

    it "doesn't modify stylesheet paths to use theme" do
      @view.stylesheet_path("test.css").should == "/stylesheets/test.css"
    end

    it "doesn't modify stylesheet paths without extension to use theme" do
      @view.stylesheet_path("test").should == "/stylesheets/test.css"
    end

    it "doesn't modify stylesheet paths with subdirectories to use theme" do
      @view.stylesheet_path("subdir/test.css").should == "/stylesheets/subdir/test.css"
    end

    it "doesn't modify stylesheet paths with leading / to use theme" do
      @view.stylesheet_path("/subdir/test.css").should == "/subdir/test.css"
    end

    it "doesn't modify stylesheet paths to use theme if path is non-local" do
      @view.stylesheet_path("http://example.com/test.css").should == "http://example.com/test.css"
    end

  end

  describe "with valid My AMEE config" do

    before :each do
      @view = TestView.new
      flexmock(MyAmee::AppConfig).should_receive(:get).with(:theme).and_return({'url' => "http://theme.domain"})
    end

    it "modifies stylesheet paths to use theme" do
      @view.stylesheet_path("test.css").should == "http://theme.domain/stylesheets/test.css"
    end

    it "modifies stylesheet paths without extension to use theme" do
      @view.stylesheet_path("test").should == "http://theme.domain/stylesheets/test.css"
    end

    it "modifies stylesheet paths with subdirectories to use theme" do
      @view.stylesheet_path("subdir/test.css").should == "http://theme.domain/stylesheets/subdir/test.css"
    end

    it "modifies stylesheet paths with leading / to use theme" do
      @view.stylesheet_path("/subdir/test.css").should == "http://theme.domain/subdir/test.css"
    end

    it "doesn't modify stylesheet paths to use theme if path is non-local" do
      @view.stylesheet_path("http://example.com/test.css").should == "http://example.com/test.css"
    end

  end

end