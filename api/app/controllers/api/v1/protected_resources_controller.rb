class Api::V1::ProtectedResourcesController < ApplicationController
  before_action :require_login
end