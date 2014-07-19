require_relative 'spec_helper'

describe "FlowRules" do
  describe "for a cave where the next available space is right" do
    let(:cave) {
      <<-HERE
      ####
      ~~ #
      ####
      HERE
    }

    it "identifies the coord of the next right cell to fill with water" do
      assert_equal([1,2], FlowRules.new(cave, [[1, 0], [1, 1]]).next_cell)
    end
  end

  describe "for a cave where the next available space is down" do
    let(:cave) {
      <<-HERE
      ###
      ~~#
      # #
      ###
      HERE
    }

    it "identifies the coord of the next cell to fill with water" do
      assert_equal([2,1], FlowRules.new(cave, [[1, 0], [1, 1]]).next_cell)
    end
  end

  describe "for a cave where there is space right and down" do
    let(:cave) {
      <<-HERE
      ####
      ~~ #
      #  #
      ####
      HERE
    }

    it "selects the down coord" do
      assert_equal([2,1], FlowRules.new(cave, [[1, 0], [1, 1]]).next_cell)
    end
  end

  describe "starting to fill the second level of water in a cave" do
    let(:cave) {
      <<-HERE
      #####
      ~~  #
      #~  #
      #~~~#
      #####
      HERE
    }

    it "fills the next available right cell above the filled level" do
      assert_equal([2,2], FlowRules.new(cave, [[2, 1], [3, 1], [3, 2], [3, 3]]).next_cell)
    end
  end

  describe "filling the second level of water in a cave" do
    let(:cave) {
      <<-HERE
      #####
      ~~  #
      #~~ #
      #~~~#
      #####
      HERE
    }

    it "fills the next available right cell above the filled level" do
      assert_equal([2,3], FlowRules.new(cave, [[3, 3], [2, 2]]).next_cell)
    end
  end

  describe "flowing over obstacles" do
    let(:cave) {
      <<-HERE
      #####
      ~~  #
      #~# #
      #####
      HERE
    }

    it "fills in above obstacles" do
      assert_equal([1,2], FlowRules.new(cave, [[1, 0], [1, 1], [2, 1]]).next_cell)
    end
  end

  describe "filling over obstacles" do
    let(:cave) {
      <<-HERE
      #####
      ~~~ #
      #~# #
      #####
      HERE
    }

    it "fills in above obstacles" do
      assert_equal([1,3], FlowRules.new(cave, [[1, 0], [1, 1], [2, 1], [1, 2]]).next_cell)
    end
  end
end
