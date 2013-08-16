require 'spec_helper'

describe ToolType do
  it { should have_many(:tools) }
end
