json.message @message

json.organization do 
  json.partial! 'api/v1/organizations/safe_organization', organization: @organization
end


