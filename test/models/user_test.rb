require 'test_helper'

class UserTest < ActiveSupport::TestCase
  def setup
    @user = User.new(
        first_name: 'Example',
        last_name: 'User',
        email: 'example@example.com',
        address: '123 Main Street',
        city: 'Nashville',
        state_id: 1,
        zip: '53213',
        password: '123456',
        password_confirmation: '123456',
      )
  end

  test 'should be valid' do
    assert @user.valid?
  end

  test 'first name should be present' do
    @user.first_name = '    '
    assert_not @user.valid?
  end

  test 'last name should be present' do
    @user.last_name = '    '
    assert_not @user.valid?
  end

  test 'address should be present' do
    @user.address = '    '
    assert_not @user.valid?
  end

  test 'city should be present' do
    @user.city = '    '
    assert_not @user.valid?
  end

  test 'state id should be present' do
    @user.state_id = '    '
    assert_not @user.valid?
  end

  test 'zip should be present' do
    @user.zip = '    '
    assert_not @user.valid?
  end

  test 'email should be present' do
    @user.email = '    '
    assert_not @user.valid?
  end

  test 'name, address, and city does not exceed 50 characters' do
    @user.first_name = 'a' * 51
    @user.last_name = 'a' * 51
    @user.address = 'a' * 51

    assert_not @user.valid?
  end

  test 'validation should accept valid email' do
    valid_emails = [
        'example@example.com',
        'EXAMPLE@example.com',
        'EX-ample@example.com',
        'EX_AMPLE@example.cn'
    ]
    valid_emails.each do |email|
      @user.email = email
      assert @user.valid?, "#{email.inspect} should be valid"
    end
  end

  test 'validation should reject invalid email' do
    valid_emails = [
        'example_example.com',
        'EXAMPLE@example_com',
        'EX-ample @example.com',
        'EX_AMPLE@example.'
    ]
    valid_emails.each do |email|
      @user.email = email
      assert_not @user.valid?, "#{email.inspect} should be valid"
    end
  end

  test 'email addresses must be unique' do
    @user.email = 'example@example.com'
    dup_user = @user.dup
    @user.save

    assert_not dup_user.valid?
  end

  test 'duplicate email with different case cannot be valid' do
    @user.email = 'example@example.com'
    dup_user = @user.dup
    dup_user.email = 'EXAMPLE@example.com'
    @user.save

    assert_not dup_user.valid?
  end

  test 'email should be saved as lowercase' do
    @user.email = 'EXAMPLE@example.com'
    @user.save
    assert_equal 'example@example.com', @user.reload.email
  end

  test 'password should be present' do
    @user.password = @user.password_confirmation = ' ' * 6
    assert_not @user.valid?
  end

  test 'password should be at least 6 characters' do
    @user.password = @user.password_confirmation = 'a' * 5
    assert_not @user.valid?
  end
end
