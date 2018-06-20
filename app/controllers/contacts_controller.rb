class ContactsController < ApplicationController
  # 入力フォーム
  def input
    @contact = Contact.new
  end

  # 確認フォーム
  def confirm
    @contact = Contact.new(contact_params)
    if !@contact.valid?
      render :input
    end
  end

  # 送信
  def send_msg
    @contact = Contact.new(contact_params)
    ContactMailer.received_email(@contact).deliver
  end
  
private
  def contact_params
    params.require(:contact).permit(:name, :email, :message)
  end
end
