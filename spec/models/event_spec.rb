require 'spec_helper'

describe Event do
  it { should validate_presence_of :name }
  it { should validate_presence_of :starts_at }
  it { should belong_to :lab }
  it { should validate_presence_of :lab }
end
