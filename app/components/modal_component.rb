class ModalComponent < JumpstartComponent
  renders_one :header
  renders_one :body
  renders_one :actions

  def initialize(size: nil, card_class: nil, container_class: nil, close_button: true)
    @size, @card_class, @container_class, @close_button = size, card_class, container_class, close_button
  end

  def container_class
    return @container_class if @container_class.present?

    case @size
    when :sm
      "modal modal-sm"
    when :lg
      "modal modal-lg"
    when :fullscreen
      "modal modal-full"
    else # :md
      "modal modal-md"
    end
  end

  def card_class
    return @card_class if @card_class.present?

    case @size
    when :fullscreen
      "modal-card full"
    else
      "modal-card"
    end
  end

  def close_button?
    !!@close_button
  end
end
