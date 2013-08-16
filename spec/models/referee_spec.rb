require 'spec_helper'

describe Referee do
  it { should belong_to(:applicant) }
  it { should belong_to(:lab_application) }
end
