require 'spec_helper'

describe Tool do
  it { should belong_to(:lab) }
  it { should belong_to(:tool_type) }
  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:tool_type) }
end
