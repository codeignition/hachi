User.create(email: 'seed_user@example.com', name: 'Seed User')

Doorkeeper::Application.create(
    name: 'SeedTestApp',
    uid: 'seed_test_app',
    secret: 'seed_test_app',
    redirect_uri: 'urn:ietf:wg:oauth:2.0:oob'
)
