require 'spec_helper'

describe User do
  before (:each) do
    @attr = { :name => "Example User",
      :email => "user@example.com",
      :password => "foty73yfgs",
      :password_confirmation => "foty73yfgs" }
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

  describe "email validations" do
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

  describe "password validations" do
    it "should require a password" do
      empty_password = { :password => "", :password_confirmation => ""}
      empty_pass_user = User.new(@attr.merge(empty_password))
      empty_pass_user.should_not be_valid
    end

    it "should require a match password confirmation" do
      mismatch_password = { :password => "", :password_confirmation => "somethingelse" }
      mismatch_pass_user = User.new(@attr.merge(mismatch_password))
      mismatch_pass_user.should_not be_valid
    end

    it "should reject short passwords" do
      short = "a" * 5 # passwords 6 - 40 chars long
      short_password = { :password => short, :password_confirmation => short }
      short_password_user = User.new(@attr.merge(short_password))
      short_password_user.should_not be_valid
    end

    it "should reject extra long passwords" do
      long = "a" * 41 # passwords 6 - 40 chars long
      long_password = { :password => long, :password_confirmation => long }
      long_password_user = User.new(@attr.merge(long_password))
      long_password_user.should_not be_valid
    end

  end

  describe "password encryption" do
    before(:each) do
      @user = User.create!(@attr)
    end

    it "should have an encrypted password" do
      @user.should respond_to(:encrypted_password)
    end

    it "should set the encrypted password" do
      @user.encrypted_password.should_not be_blank
    end

    describe "has_password? method" do

      it "should be true if the passwords match" do
        @user.has_password?(@attr[:password]).should be_true
      end

      it "should be false if the passwords don't match" do
        @user.has_password?("invalid").should be_false
      end
    end
    
    describe "authenticate method" do
      
      it "should return nil on email/password mismatch" do
        wrong_password_user = User.authenticate(@attr[:email], "wrongpass")
        wrong_password_user.should be_nil
      end
      
      it "should return nil for an email address with no user" do
        no_user = User.authenticate("missinguser", @attr[:password])
        no_user.should be_nil
      end
      
      it "should return user on correct email/password" do
        found_user = User.authenticate(@attr[:email], @attr[:password])
        found_user.should == @user
      end
    end
  end
end
