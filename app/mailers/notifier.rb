class Notifier < ActionMailer::Base
  default :from => "noreply@learnto.com", :host => "learn.com"
  
  def activation_instructions(user)
    @url = activate_account_url(user.perishable_token)
    mail(:to => user.email, :subject => "Activation Instructions", :date => Time.now, :from => "noreply@learnto.com")
  end

  def welcome(user)
    @url = root_url
    mail(:to => user.email, :subject => "Welcome!", :date => Time.now)
  end
  
  def password_reset_instructions(user) 
    @url = edit_password_reset_url(user.perishable_token)
    mail(:to => user.email, :subject => "Password Reset Instructions", :date => Time.now, :from => "noreply@learnto.com")       
	end  

end
