require 'spec_helper'

describe Event do

  describe "relationships" do
    it { should belong_to :creator }
    it { should validate_presence_of :name }
    pending { should validate_presence_of :starts_at }
    it { should belong_to :lab }
    it { should validate_presence_of :lab }
  end

  it "has to_s" do
    expect(Lab.new(name: 'some name').to_s).to eq 'some name'
  end

end
