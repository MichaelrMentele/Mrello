require 'rails_helper'

describe Comment do 
  it { is_expected.to validate_presence_of(:payload) }
  it { is_expected.to belong_to(:card) }
end