require 'spec_helper'

describe Event do
  it { should validate_presence_of :name }
  it { should belong_to :creator }
  pending { should validate_presence_of :starts_at }
  it { should belong_to :lab }
  pending { should validate_presence_of :lab }
end
