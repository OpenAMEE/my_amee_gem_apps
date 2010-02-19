require File.dirname(__FILE__) + '/spec_helper.rb'
require 'action_controller'
require 'action_view'
require 'my_amee/images'

describe ActionView::Helpers::AssetTagHelper do

  class TestView < ActionView::Base
    include ActionView::Helpers::AssetTagHelper
  end

  describe "without valid My AMEE config" do

    before :each do
      @view = TestView.new
      flexmock(MyAmee::AppConfig).should_receive(:get).with(:theme).and_return(nil)
    end

    it "doesn't modify image paths to use theme" do
      @view.image_path("test.png").should == "/images/test.png"
    end

    it "doesn't modify image paths with subdirectories to use theme" do
      @view.image_path("subdir/test.png").should == "/images/subdir/test.png"
    end

    it "doesn't modify image paths with leading / to use theme" do
      @view.image_path("/subdir/test.png").should == "/subdir/test.png"
    end

    it "doesn't modify image paths to use theme if path is non-local" do
      @view.image_path("http://example.com/test.png").should == "http://example.com/test.png"
    end

  end

  describe "with valid My AMEE config" do

    before :each do
      @view = TestView.new
      flexmock(MyAmee::AppConfig).should_receive(:get).with(:theme).and_return({'url' => "http://theme.domain"})
    end

    it "modifies image paths to use theme" do
      @view.image_path("test.png").should == "http://theme.domain/images/test.png"
    end

    it "modifies image paths with subdirectories to use theme" do
      @view.image_path("subdir/test.png").should == "http://theme.domain/images/subdir/test.png"
    end

    it "modifies image paths with leading / to use theme" do
      @view.image_path("/subdir/test.png").should == "http://theme.domain/subdir/test.png"
    end

    it "doesn't modify image paths to use theme if path is non-local" do
      @view.image_path("http://example.com/test.png").should == "http://example.com/test.png"
    end

  end

end