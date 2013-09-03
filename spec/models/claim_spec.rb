require 'spec_helper'

describe Claim do
  it { should belong_to :lab }
  it { should belong_to :user }
end
