require 'test_helper'

class ManagerMailerTest < ActionMailer::TestCase
  test "invite_manager" do
    mail = ManagerMailer.invite_manager
    assert_equal "Invite manager", mail.subject
    assert_equal ["to@example.org"], mail.to
    assert_equal ["from@example.com"], mail.from
    assert_match "Hi", mail.body.encoded
  end

end
