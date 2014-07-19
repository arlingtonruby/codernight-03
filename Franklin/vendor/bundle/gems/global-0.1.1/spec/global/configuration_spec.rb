require "spec_helper"

describe Global::Configuration do
  let(:hash){ { "key" => "value", "nested" => { "key" => "value" } } }
  let(:configuration){ described_class.new hash }

  describe "#hash" do
    subject{ configuration.hash }

    it{ is_expected.to eq(hash) }
  end

  describe "#to_hash" do
    subject{ configuration.to_hash }

    it{ is_expected.to eq(hash) }
  end

  describe "key?" do
    subject{ configuration.key?(:key) }

    it{ is_expected.to be_truthy }
  end

  describe "#[]" do
    subject{ configuration[:key] }

    it{ is_expected.to eq("value") }
  end

  describe "#[]=" do
    subject{ configuration[:new_key] }

    before{ configuration[:new_key] = "new_value" }

    it{ is_expected.to eq("new_value") }
  end

  describe "#inspect" do
    subject{ configuration.inspect }

    it{ is_expected.to eq(hash.inspect) }
  end

  describe "#filter" do
    subject{ configuration.filter(filter_options) }

    context "when include all" do
      let(:filter_options){ { only: :all } }

      it{ should == {"key"=>"value", "nested"=>{"key"=>"value"}} }
    end

    context "when except all" do
      let(:filter_options){ { except: :all } }

      it{ should == {} }
    end

    context "when except present" do
      let(:filter_options){ { except: %w(key) } }

      it{ should == {"nested"=>{"key"=>"value"}} }
    end

    context "when include present" do
      let(:filter_options){ { only: %w(key) } }

      it{ should == {"key"=>"value"} }
    end

    context "when empty options" do
      let(:filter_options){ {} }

      it{ should == {} }
    end
  end

  describe "#method_missing" do
    context "when key exist" do
      subject{ configuration.key }

      it{ is_expected.to eq("value") }
    end

    context "when key does not exist" do
      subject{ configuration.some_key }

      it{ expect { subject }.to raise_error(NoMethodError) }
    end

    context "with nested hash" do
      subject{ configuration.nested.key }

      it{ is_expected.to eq("value") }
    end
  end
end