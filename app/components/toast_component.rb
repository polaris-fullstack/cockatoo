class ToastComponent < JumpstartComponent
  renders_one :icon
  renders_one :link

  attr_reader :title, :description, :dismissable, :dismiss_after

  def initialize(opts = {})
    opts.deep_symbolize_keys!
    @title = opts[:title]
    @description = opts[:description]
    @dismissable = opts.fetch(:dismissable, true)
    @dismiss_after = opts[:dismiss_after]
    @icon = opts[:icon]
    @icon_name = opts[:icon_name]&.to_sym
    @link = opts[:link]
  end

  def dismissable?
    !!@dismissable
  end

  def icon
    if @icon
      @icon
    elsif @icon_name
      FlashHelper::ICONS[@icon_name].html_safe
    end
  end

  def link
    if @link.is_a?(Hash)
      @view_context.link_to(@link.fetch(:text), @link.fetch(:url))
    else
      @link
    end
  end
end
