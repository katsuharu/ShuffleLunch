class ContactMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.contact_mailer.contact_contents.subject
  #
  def contact_contents params
    @contents = params
    mail to: "traveler.18.challenge@gmail.com", subject: "【シャッフルランチ】お問い合わせ"
  end
end
