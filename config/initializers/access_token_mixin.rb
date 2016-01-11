Doorkeeper::AccessTokenMixin.module_eval do
  def as_json(_options = {})
    {
        resource_owner_id: resource_owner_id.to_s,
        scopes: scopes,
        expires_in_seconds: expires_in_seconds,
        application: {uid: application.try(:uid)},
        created_at: created_at.to_i
    }
  end
end
