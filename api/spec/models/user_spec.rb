require 'rails_helper'

describe User do 
  it { is_expected.to validate_presence_of(:fullname) }
  it { is_expected.to have_many(:lists) }
end