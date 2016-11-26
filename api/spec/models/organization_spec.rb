require "rails_helper"

describe Organization do 
  it { is_expected.to validate_presence_of(:title) }

  it { is_expected.to have_many(:memberships) }
  it { is_expected.to have_many(:ownerships) }
end