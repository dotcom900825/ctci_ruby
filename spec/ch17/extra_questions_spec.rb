
require_relative '../spec_helper'
require_relative '../../lib/extra_questions'

describe "Modest questions" do
  describe "number of trailing zeros of factorial" do
    it "should return correct result" do
      # 15! = 1307674368000
      Ch17::count_fact_zeros(15).should == 3
    end
  end

  describe "max number of two without comparing" do
    it "should return the max number" do
      Ch17::get_max(10, 20).should == 20
      Ch17::get_max(-10, 20).should == 20
      Ch17::get_max(10, -20).should == 10
    end
  end

  describe "the game of master mind" do
    before do
      @result = Ch17::master_mind("GGRR", "RGBY")
    end

    it "should raise Argument Error if pass in nil" do
      expect {Ch17::master_mind(nil, nil)}.to raise_error(ArgumentError)
      expect {Ch17::master_mind("GGRR", nil)}.to raise_error(ArgumentError)
      expect {Ch17::master_mind(nil, "GGRR")}.to raise_error(ArgumentError)
      expect {Ch17::master_mind(nil, "GRR")}.to raise_error(ArgumentError)
      expect {Ch17::master_mind("GRR", nil)}.to raise_error(ArgumentError)
    end
    it "should return correct result" do
      @result.should be_an_instance_of(Ch17::Result)
      @result.hits.should == 1
      @result.pseudo_hits.should == 1
    end
  end

  describe "unsorted sequence" do
    before do
      @ary = [1, 2, 4, 7, 10, 11, 7, 12, 6, 7, 16, 18, 19]
    end

    it "should return unsorted sequence" do
      Ch17::find_unsorted_sequence(@ary).should eql [3, 9]
    end
  end

  describe "english phrase of integers" do
    it "should raise error if not integer" do
      expect { Ch17::english_of_integer(1.1)}.to raise_error(ArgumentError)
    end

    it "should print correct english phrase" do
      Ch17::english_of_integer(156).should eql "One Hundred Fifty Six"
      Ch17::english_of_integer(-156).should eql "Negative One Hundred Fifty Six"
      Ch17::english_of_integer(0).should eql "Zero"
      Ch17::english_of_integer(1156).should eql "One Thousand One Hundred Fifty Six"
    end
  end
end
