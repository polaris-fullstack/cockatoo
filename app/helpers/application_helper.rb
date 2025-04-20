module ApplicationHelper
  include Pagy::Frontend

  # Returns classes for sidebar nav links
  def sidebar_link_class(step)
    active = (
      if defined?(@current_step)
        @current_step == step
      elsif params[:action].to_s.include?("#{step}")
        true
      else
        false
      end
    )
    base = "block px-4 py-2 rounded transition-colors duration-150 hover:bg-blue-50 hover:text-blue-700 focus:bg-blue-100 focus:text-blue-900"
    active ? "#{base} bg-blue-100 text-blue-700 font-bold" : base
  end
end
