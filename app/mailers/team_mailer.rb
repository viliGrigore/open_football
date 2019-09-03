# frozen_string_literal: true

class TeamMailer < ApplicationMailer
  def send_report(added_records, existing_records)
    @teams = Team.all
    @added_records = added_records
    @existing_records = existing_records
    mail(
      to: 'some_email_address@gmail.com',
      bcc: '',
      subject: 'Teams'
    )
  end
end
