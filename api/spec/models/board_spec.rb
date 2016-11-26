require "rails_helper"

describe Board do 
  it { is_expected.to validate_presence_of(:ownership_id) }
  it { is_expected.to belong_to(:ownership) }
  
  it { is_expected.to have_many(:lists) }
end