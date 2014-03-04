require 'spec_helper'


describe "Mate runner" do
  
  before(:each) do
    tm_selected_files(__FILE__)
    @runner = Mate::Runner.new
  end
  
  it "should have project_directory" do
    @runner.send(:project_directory).should =~ /Support/
  end
  
  it "should have files" do
    @runner.send(:files).should_not be_empty
  end
  
end