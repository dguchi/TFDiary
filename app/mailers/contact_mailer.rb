class ContactMailer < ApplicationMailer
  default from: ENV['MAIL_ADDRESS']   # 送信元アドレス
  default bcc: ENV['BCC_MAIL']     # 送信先アドレス
 
  def received_email(contact)
    @contact = contact
    mail(:to => @contact.email, :subject => '[TFDiary] お問い合わせを承りました')
  end
end
