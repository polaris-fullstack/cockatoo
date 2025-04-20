module DeviceFormat
  # Sets the request variant based upon the user agent
  #
  # For simplicity, we only register a "native" format for Hotwire Native apps
  # but you may add others like "phone", "tablet" to render different partials
  # based upon the device

  extend ActiveSupport::Concern

  included do
    before_action :set_variant_for_device
  end

  private

  def set_variant_for_device
    if hotwire_native_app?
      request.variant = :native
    end
  end
end
