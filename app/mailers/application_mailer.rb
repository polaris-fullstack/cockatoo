class ApplicationMailer < ActionMailer::Base
  default from: Jumpstart.config.default_from_email
  layout "mailer"

  # Include any view helpers from your main app to use in mailers here
  helper ApplicationHelper
end
