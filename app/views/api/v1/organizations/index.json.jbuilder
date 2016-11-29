json.message @message

json.organizations do
  json.array! @organizations, partial: 'api/v1/organizations/safe_organization', as: :organization
end