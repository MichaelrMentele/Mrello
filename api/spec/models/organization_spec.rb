require "rails_helper"

describe Organization do 
  it { is_expected.to belong_to(:admin) }
  it { is_expected.to have_many(:users) }
  it { is_expected.to have_many(:join_requests) }
end