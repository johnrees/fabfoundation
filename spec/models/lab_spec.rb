require 'spec_helper'

describe Lab do
  it { should validate_presence_of(:name) }
end
