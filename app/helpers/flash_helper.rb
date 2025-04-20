module FlashHelper
  # Flash set as Hashes are used for toasts

  ICONS = {
    alert: '<svg xmlns="http://www.w3.org/2000/svg" class="icon-alert" width="20" height="20" viewBox="0 0 20 20"><path fill-rule="evenodd" d="M8.257 3.099c.765-1.36 2.722-1.36 3.486 0l5.58 9.92c.75 1.334-.213 2.98-1.742 2.98H4.42c-1.53 0-2.493-1.646-1.743-2.98l5.58-9.92zM11 13a1 1 0 11-2 0 1 1 0 012 0zm-1-8a1 1 0 00-1 1v3a1 1 0 002 0V6a1 1 0 00-1-1z" clip-rule="evenodd" /></svg>',
    notice: '<svg xmlns="http://www.w3.org/2000/svg" class="icon-notice" width="20" height="20" viewBox="0 0 20 20"><path fill-rule="evenodd" d="M18 10a8 8 0 11-16 0 8 8 0 0116 0zm-7-4a1 1 0 11-2 0 1 1 0 012 0zM9 9a1 1 0 000 2v3a1 1 0 001 1h1a1 1 0 100-2v-3a1 1 0 00-1-1H9z" clip-rule="evenodd" /></svg>',
    success: '<svg xmlns="http://www.w3.org/2000/svg" class="icon-success" width="20" height="20" viewBox="0 0 20 20"><path fill-rule="evenodd" d="M10 18a8 8 0 100-16 8 8 0 000 16zm3.707-9.293a1 1 0 00-1.414-1.414L9 10.586 7.707 9.293a1 1 0 00-1.414 1.414l2 2a1 1 0 001.414 0l4-4z" clip-rule="evenodd" /></svg>',
    default: '<svg xmlns="http://www.w3.org/2000/svg" class="icon-default" width="20" height="20" viewBox="0 0 20 20"><path fill-rule="evenodd" d="M18 10a8 8 0 11-16 0 8 8 0 0116 0zm-7-4a1 1 0 11-2 0 1 1 0 012 0zM9 9a1 1 0 000 2v3a1 1 0 001 1h1a1 1 0 100-2v-3a1 1 0 00-1-1H9z" clip-rule="evenodd" /></svg>'
  }

  def alert
    value = super
    value unless value.is_a?(Hash)
  end

  def notice
    value = super
    value unless value.is_a?(Hash)
  end

  def toasts
    flash.select { |k, v| v.is_a?(Hash) }
  end

  def banner(message: nil, classes: "banner-info", icon_name: nil, &block)
    icon = ICONS[icon_name].html_safe if icon_name
    block ||= ->(tag_builder) { icon.to_s + tag.p(sanitize(message)) }
    tag.div class: class_names("banner", classes), role: "alert", &block
  end

  def impersonation_banner
    return if current_user == true_user

    banner classes: "banner-impersonate" do
      tag.span("Logged in as <b>#{link_to "#{current_user.name} (#{current_user.email})", main_app.madmin_user_path(current_user), class: "underline"}</b>".html_safe) +
        button_to("Log out", main_app.madmin_user_impersonate_path(current_user), method: :delete, form_class: "inline-block", class: "btn btn-secondary btn-small")
    end
  end
end
