require "rails_helper"

describe Board do 
  it { is_expected.to validate_presence_of(:owner_id) }

  it { is_expected.to belong_to(:owner) }
  
  it { is_expected.to have_many(:lists) }
end