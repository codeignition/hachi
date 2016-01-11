require 'rails_helper'

describe 'AccessTokenMixin' do
  let(:app) {
    Doorkeeper::Application.create(id: 1,
                                   name: 'example_app',
                                   uid: 12,
                                   secret: 123,
                                   redirect_uri: "",
                                   scopes: "",
                                   created_at: nil,
                                   updated_at: nil)
  }

  let(:token) {
    Doorkeeper::AccessToken.create(id: 1,
                                   resource_owner_id: 1,
                                   application_id: app.id,
                                   token: 1,
                                   refresh_token: 2,
                                   expires_in: DateTime.now + 1.day,
                                   revoked_at: nil,
                                   created_at: DateTime.now,
                                   scopes: nil)
  }

  let(:token_hash) {
    {
        resource_owner_id: token.resource_owner_id.to_s,
        scopes: token.scopes,
        expires_in_seconds: token.expires_in_seconds,
        application: {uid: nil},
        created_at: token.created_at.to_i,
    }
  }

  it 'generates a hash when tried to convert token to json' do
    expect(token.as_json).to eq token_hash
  end

  it 'generates a hash with resource owner id of String type' do
    expect(token.as_json[:resource_owner_id]).to be_kind_of(String)
  end
end