require 'spec_helper'

describe User do
  before (:each) do
    @attr = { :name => "Example User", :email => "user@example.com" }
  end
  
  it "should create a new instance given valid attributes" do
    User.create!(@attr)
  end
  
  it "should require a name" do
    empty_name = { :name => "" }
    @attr = @attr.merge(empty_name)
    empty_name_user = User.new(@attr)
    empty_name_user.should_not be_valid
  end

  it "should require an email" do
    empty_email = { :email => "" }
    @attr = @attr.merge(empty_email)
    empty_email_user = User.new(@attr)
    empty_email_user.should_not be_valid
  end
  
  it "should reject names that are too long" do
    long_name = "a" * 51
    long_name_user = User.new(@attr.merge(:name => long_name))
    long_name_user.should_not be_valid
  end
  
  it "should have a valid email address" do
    addresses = %w[user@foo.com THE_USER@foo.bar.org first.last@foo.jp]
    addresses.each do |address|
      valid_email_user =  User.new(@attr.merge({ :email => address }))
      valid_email_user.should be_valid
    end
  end
  
  it "should reject invalid email addresses" do
    addresses = %w[user@foo,com user_at_foo.org example.user@foo.]
    addresses.each do |address|
      invalid_email_user = User.new(@attr.merge({ :email => address }))
      invalid_email_user.should_not be_valid
    end
  end
  
  it "should reject duplicate email addresses" do
    User.create!(@attr)
    user_with_duplicate_email = User.new(@attr)
    user_with_duplicate_email.should_not be_valid
  end

  it "should reject identical email addresses ignore case" do
    upcase_email = @attr[:email].upcase
    User.create!(@attr.merge( { :email => upcase_email } ))
    user_with_duplicate_email = User.new(@attr)
    user_with_duplicate_email.should_not be_valid
  end
  
end
