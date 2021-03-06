require 'rails_helper'

describe User do 
  it { is_expected.to validate_presence_of(:fullname) }
  it { is_expected.to validate_presence_of(:email) }
  it { is_expected.to validate_uniqueness_of(:email) }
  
  it { is_expected.to have_many(:organizations) }
  it { is_expected.to have_many(:memberships) }

  it { is_expected.to have_many(:boards) }
  it { is_expected.to have_many(:lists) }
  it { is_expected.to have_many(:cards) }
end