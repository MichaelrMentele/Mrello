require 'rails_helper'

describe Membership do 
  it { is_expected.to validate_presence_of(:organization_id) }
  it { is_expected.to validate_presence_of(:user_id) }

  it { is_expected.to belong_to(:organization) }
  it { is_expected.to belong_to(:user) }
end
