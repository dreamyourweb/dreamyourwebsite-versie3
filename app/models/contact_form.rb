class ContactForm < MailForm::Base
  attribute :info  
  attribute :message
  attribute :to
  attribute :subject

	validates :info, :presence => true
	validates :to, :presence => true, :format => {:with => /^([^@\s]+)@dreamyourweb.nl$/}
	validates :message, :presence => true 

  #attribute :nickname,  :captcha  => true

  # Declare the e-mail headers. It accepts anything the mail method
  # in ActionMailer accepts.
  def headers
    {
      :subject => %(<#{subject}>),
			:to => %(#{to}),
      :from => "info@dreamyourweb.nl"
    }
  end
end
