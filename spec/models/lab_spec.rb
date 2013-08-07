require 'spec_helper'

describe Lab do
  it { should belong_to :creator }
  it { should validate_presence_of :name }
end
