# Add error messages inline after form fields

ActionView::Base.field_error_proc = proc do |html_tag, instance|
  html = ""

  form_fields = %w[input select textarea trix-editor]

  # Elements that can't have a border
  ignored_input_types = %w[checkbox hidden]

  Nokogiri::HTML::DocumentFragment.parse(html_tag).children.each do |element|
    html += if form_fields.include?(element.node_name) && ignored_input_types.exclude?(element.get_attribute("type"))
      element.add_class("error")

      attribute = instance.object.class.human_attribute_name(instance.send(:sanitized_method_name))
      errors = instance.error_message.to_sentence

      <<~HTML
        #{element}
        <p class="form-hint error">#{attribute} #{errors}</p>
      HTML
    else
      element.to_s
    end
  end

  html.html_safe
end
