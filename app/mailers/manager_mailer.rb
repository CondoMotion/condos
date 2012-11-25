class UserMailer < ActionMailer::Base
  default from: "info@condomotion.com"

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.manager_mailer.invite_manager.subject
  #
  def invite_user(invitee, invitedBy)
    @invitee = invitee
    @invitedBy = invitedBy

    mail to: invitee.email, subject: "You've been invited to Condo Motion"
  end

end
