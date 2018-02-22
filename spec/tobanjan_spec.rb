require "spec_helper"

RSpec.describe Tobanjan do
  it "has a version number" do
    expect(Tobanjan::VERSION).not_to be nil
  end

  describe Tobanjan::CandidateList do

    let(:members) {[:ishige, :tanaka, :yamane]}

    describe "#choice" do
      subject(:candidate_list) { Tobanjan::CandidateList.create(members) }

      it "回数が偏らない範囲で無作為に取り出す" do
        Tobanjan::Choicer.stub(:random_idx).and_return(0)
        expect(candidate_list.choice!).to eq members[0]
        expect(candidate_list.choice!).to eq members[1]
        expect(candidate_list.choice!).to eq members[2]
        expect(candidate_list.choice!).to eq members[0]
        expect(candidate_list.choice!).to eq members[1]
        expect(candidate_list.choice!).to eq members[2]
      end
    end

    describe "#choice_by_column_name" do
      subject(:candidate_list) { Tobanjan::CandidateList.create(members, [:count]) }
      it "回数が偏らない範囲で無作為に取り出す" do
        Tobanjan::Choicer.stub(:random_idx).and_return(0)
        expect(candidate_list.choice_by_column_name!(:count)).to eq members[0]
        expect(candidate_list.choice_by_column_name!(:count)).to eq members[1]
        expect(candidate_list.choice_by_column_name!(:count)).to eq members[2]
        expect(candidate_list.choice_by_column_name!(:count)).to eq members[0]
        expect(candidate_list.choice_by_column_name!(:count)).to eq members[1]
        expect(candidate_list.choice_by_column_name!(:count)).to eq members[2]
      end
    end

  end
end
