require 'spec_helper'

describe Application do
  it { should validate_presence_of(:lab) }
  it { should validate_presence_of(:creator) }
  it { should belong_to(:lab)}
  it { should belong_to(:creator)}
end
