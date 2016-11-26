require 'rails_helper'

describe Ownership do 
  it { is_expected.to validate_presence_of(:owner_type) }
  it { is_expected.to validate_presence_of(:owner_id) }

  it { is_expected.to belong_to(:owner) }
  it { is_expected.to have_many(:boards) }
end