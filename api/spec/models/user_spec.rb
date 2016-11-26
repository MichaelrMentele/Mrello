require 'rails_helper'

describe User do 
  it { is_expected.to validate_presence_of(:fullname) }
  it { is_expected.to validate_presence_of(:email) }
  it { is_expected.to validate_uniqueness_of(:email) }
  
  it { is_expected.to have_one(:board) }
  it { is_expected.to belong_to(:organization) }
  it { is_expected.to have_many(:join_requests) }
end