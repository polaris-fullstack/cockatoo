Madmin.site_name = Jumpstart.config.application_name

Madmin.menu.before_render do
  add label: "Sidekiq", url: Rails.application.routes.url_helpers.madmin_sidekiq_web_path, position: 1 if defined? ::Sidekiq::Web
  add label: "Users & Accounts", position: 2
  add label: "Payments", position: 3
  add label: "Resources", position: 4
end
