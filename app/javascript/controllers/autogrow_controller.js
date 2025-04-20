// Autogrows textareas based on content
//
// Example Usage:
// <%= form.text_area :value, data: {controller: "autogrow", action: "input->autogrow#autogrow"} %>

import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  connect() {
    this.autogrow()
  }

  autogrow() {
    this.element.style.height = 'auto'

    // offsetHeight accounts for borders while clientHeight & scrollHeight do not
    let borderHeight = (this.element.offsetHeight - this.element.clientHeight)

    this.element.style.height = `${this.element.scrollHeight + borderHeight}px`
  }
}
