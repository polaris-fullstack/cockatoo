module PagesHelper
  def title(page_title)
    content_for(:title) { page_title }
  end

  def viewport_meta_tag(content: "width=device-width, initial-scale=1", hotwire_native: "maximum-scale=1.0, user-scalable=0")
    full_content = [content, (hotwire_native if hotwire_native_app?)].compact.join(", ")
    tag.meta name: "viewport", content: full_content
  end

  def first_page?
    @pagy&.page == 1
  end
end
