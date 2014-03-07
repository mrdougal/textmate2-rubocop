require 'spec_helper'


describe "Mate runner" do
  
  before(:each) do
    tm_selected_files(__FILE__)
    @runner = Mate::Runner.new
  end
  
  # it "should be able to run" do
  #   pending 'this is super noisy'
  #   # lambda { @runner.current_file }.should_not raise_error
  # end
  
  it "should have project_path" do
    @runner.send(:project_path).should =~ /Support/
  end
  
  it "should responed to multiple_files" do
    @runner.send(:multiple_files).should_not be_empty
  end
  
end