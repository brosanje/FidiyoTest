require 'rails_helper'
require 'support/violate_check_constraint_matcher'

##describe User do
RSpec.describe User, type: :model do
  describe 'email' do
    let(:user) {
      uu = User.new({name: "Fred Pickle", email: "foo@example.com", password: "qw3rtyu1oPP", password_confirmation: "qw3rtyu1oPP"})
      uu.skip_confirmation!
      uu.save
      ##Rails.logger.debug uu.to_yaml
      uu
    }
    
    it "absolutely prevents invalid email addresses" do
      expect {
        ##Rails.logger.debug user.to_yaml
        user.update_attribute(:email, "foo@b@r.com")
        ##Rails.logger.debug user.to_yaml
      #}.to raise_error(ActiveRecord::StatementInvalid, /email_must_be_valid_email/i)
      }.to violate_check_constraint(:email_must_be_valid_email)
    end
  end
end
