require "rails_helper"

describe Organization do 
  it { is_expected.to belong_to(:user) }
  it { is_expected.to have_many(:users) }
end