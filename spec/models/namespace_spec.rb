require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Namespace do

  before(:each) do
    @valid_attributes = {
      :name => "aname"
    }
  end

  describe "checking uniqueness" do
    before do
      # The matcher needs an existing record
      Factory(:namespace)
    end
    it { should validate_uniqueness_of(:name).scoped_to([:owner_id, :owner_type]) }
    it { should validate_uniqueness_of(:address) }
  end
  it { should validate_format_of(:name).with('foo') }
  it { should validate_format_of(:name).not_with('bad_char').with_message(/alphanumeric/) }
  it { should validate_format_of(:name).not_with('1').with_message(/2 or more/) }

  it { should validate_presence_of(:address) }
  it { should validate_format_of(:address).with('foo-bar') }
  it { should validate_format_of(:address).not_with('foo').with_message(/invalid/) }
  it { should validate_format_of(:address).not_with('foo-bar-baz').with_message(/invalid/) }

  describe '#title' do

    describe "before saving" do
      before do
        @namespace = Factory(:namespace)
      end
      it "should have a defaulted title attribute before saving" do
        @namespace.title.should == @namespace.name.titleize
      end
    end

    describe "after saving" do
      before do
        @namespace = Factory(:namespace)
      end
      it "should default the title attribute" do
        @namespace.title.should == @namespace.name.titleize
      end

    end

  end

  describe "#default?" do

    describe "when the name is 'default'" do
      before { @namespace = Factory(:namespace, :name => 'default') }
      it "should be true" do
        @namespace.should be_default
      end
    end

    describe "when the name is not 'default'" do
      before { @namespace = Factory(:namespace) }
      it "should be false" do
        @namespace.should_not be_default
      end
    end
    
  end
    
end
