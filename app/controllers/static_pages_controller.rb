class StaticPagesController < ApplicationController

  before_action :logged_in_user
  before_action :correct_user

  def contact
  end

  def success_mail
    user = User.find(1)
    SuccessMailer.contact_contents(contact_params).deliver_now
    flash[:success] = "マッチング成功メールの送信が完了しました。"
    redirect_to root_url
  end

  def send_mail
    ContactMailer.contact_contents(contact_params).deliver_now
    flash[:success] = "送信が完了しました。"
    redirect_to :action => "contact"
  end

  private

    def contact_params
      params.require(:contact).permit(:name,
                                      :email,
                                      :content,
                                      )
    end
end
