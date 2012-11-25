class PostMailer < ActionMailer::Base
  default from: "from@example.com"

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.post_mailer.new_post.subject
  #
  def new_post(post, attachment_url)
    @greeting = "Hi"
    @post = post
    @attachment_url = attachment_url

    mail(:to => 'earlynovrock@gmail.com',
         :subject => "New #{@post.post_type.singularize.titleize} Post!")
  end
end
