require "spec_helper"

RSpec.describe Tobanjan do
  it "has a version number" do
    expect(Tobanjan::VERSION).not_to be nil
  end

  describe Tobanjan::CandidateList do
    let(:pokemon) {[:pikachu, :raichu, :dedenne]}

    subject(:candidate_list) { Tobanjan::CandidateList.create(pokemon, [:count]) }
    it "回数が偏らない範囲で無作為に取り出す" do
      Tobanjan::Choicer.stub(:random_idx).and_return(0)
      expect(candidate_list.choice_by_column_name!(:count)).to eq pokemon[0]
      expect(candidate_list.choice_by_column_name!(:count)).to eq pokemon[1]
      expect(candidate_list.choice_by_column_name!(:count)).to eq pokemon[2]
      expect(candidate_list.choice_by_column_name!(:count)).to eq pokemon[0]
      expect(candidate_list.choice_by_column_name!(:count)).to eq pokemon[1]
      expect(candidate_list.choice_by_column_name!(:count)).to eq pokemon[2]
    end
  end
end
