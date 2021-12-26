def authentication_headers
  FactoryBot.create(:user).create_new_auth_token
end

def authentication_headers_gerente
  FactoryBot.create(:user, :manager).create_new_auth_token
end

def authentication_headers_admin
  FactoryBot.create(:user, :admin).create_new_auth_token
end