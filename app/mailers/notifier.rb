class Notifier < ActionMailer::Base
  default from: "noreply@classroom.com"
  default host: "classroom.com"
  
  def activation_instructions(user)
    @url = activate_account_url(user.perishable_token)
    mail(:to => user.email, :subject => "Activation Instructions")
  end

  def welcome(user)
    @url = root_path
    mail(:to => user.email, :subject => "Welcome!")
  end
end
