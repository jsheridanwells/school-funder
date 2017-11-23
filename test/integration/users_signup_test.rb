require 'test_helper'

class UsersSignupTest < ActionDispatch::IntegrationTest

  test "invalid signup information does not write to db" do
    get signup_path
    assert_no_difference 'User.count' do
      post users_path, params: { user: { first_name:  "",
                                         last_name: '',
                                         address: '',
                                         city: '',
                                         state: '',
                                         zip: '',
                                         email: "user@invalid",
                                         password:              "123",
                                         password_confirmation: "456" } }
    end
    assert_template 'users/new'
  end

  test 'valid signup informationw writes to db' do
    get signup_path
    assert_difference 'User.count', 0 do
      post signup_path, params: { user: { first_name:  "Jeremy",
                                         last_name: 'Example',
                                         address: '123 Main',
                                         city: 'Nashville',
                                         state: 1,
                                         zip: '48187',
                                         email: "user@valid.com",
                                         password:              "123456",
                                         password_confirmation: "123456" } }
    end
    assert_template '/'
  end

end
