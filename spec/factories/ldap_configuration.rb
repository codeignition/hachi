FactoryGirl.define do
  factory :ldap_configuration, class: LdapConfiguration do
    host '192.168.33.101'
    port '389'
    dn 'example'
    search_base 'example_search_base'
    email 'test@example.com'
    ssh_public_key '123456789ABCDEFGHI'
    hachi_admin_usernames 'test_one,test_two,test_3'
    ldap_admin_username 'test_admin'
    ldap_admin_password '!Abcd1234'
  end
end
