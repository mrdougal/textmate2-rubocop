require 'spec_helper'
require 'mate/env'

# To aid in testing modules
class Dummy
  include Mate::Env
end

describe 'mate env' do

  it 'should define a project_path' do
    Dummy.new.project_path.should =~ /Support/
  end

  it 'should define a vendor_path' do
    Dummy.new.vendor_path.should =~ /Support\/vendor/
  end

  it 'should define a multiple_files' do
    Dummy.new.multiple_files.should_not be_empty
  end

  it 'should define single_file' do
    Dummy.new.single_file.should =~ /Support/
  end

  describe 'names' do

    ['John', 'John Smith', 'John Doe'].each do |val|

      before(:each) do
        ENV['TM_FULLNAME'] = val
      end

      it 'should have user first name' do
        Dummy.new.users_first_name.should =~ /jo/i
      end
    end

    it 'should have an array of names' do
      Dummy.new.users_names.length.should be(2)
    end

    it "should not return anyting if the TM_FULLNAME is not set" do
      ENV['TM_FULLNAME'] = ''
      Dummy.new.users_first_name.should == ''
    end

  end
end
