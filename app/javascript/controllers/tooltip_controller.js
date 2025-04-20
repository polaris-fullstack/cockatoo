// Example usage:
// <div data-controller="tooltip" data-tooltip-content-value="Hello world"></div>

import { Controller } from "@hotwired/stimulus"
import { autoUpdate, autoPlacement, computePosition, offset, arrow, shift } from "@floating-ui/dom"

export default class extends Controller {
  static values = {
    content: String,
    placement: String,
    offset: 6,
    allowHtml: true
  }

  connect() {
    this.createTooltipElements()
    this.cleanup = autoUpdate(this.element, this.tooltip, this.updatePosition.bind(this))
    this.addEvents()
  }

  disconnect() {
    this.tooltip?.remove()
    this?.cleanup()
  }

  createTooltipElements() {
    this.tooltip = document.createElement("div")
    this.tooltip.dataset.tooltipTarget = "content"
    this.tooltip.classList.add("tooltip")
    if (this.allowHtmlValue) {
      this.tooltip.innerHTML= this.contentValue
    } else {
      this.tooltip.textContent = this.contentValue
    }

    this.arrow = document.createElement("div")
    this.arrow.classList.add("arrow")

    this.tooltip.appendChild(this.arrow)
    document.body.appendChild(this.tooltip)
  }

  updatePosition() {
    computePosition(this.element, this.tooltip, {
      middleware: [
        autoPlacement({
          allowedPlacements: (this.placementValue ? [this.placementValue] : undefined),
        }),
        shift({
          mainAxis: true,
          crossAxis: true,
          padding: 2,
        }),
        offset(this.offsetValue),
        arrow({element: this.arrow}),
      ]
    }).then(({x, y, placement, middlewareData}) => {
      Object.assign(this.tooltip.style, {
        left: `${x}px`,
        top: `${y}px`
      });

      const side = placement.split("-")[0];

      const staticSide = {
        top: "bottom",
        right: "left",
        bottom: "top",
        left: "right"
      }[side];

      if (middlewareData.arrow) {
        const { x, y } = middlewareData.arrow;
        Object.assign(this.arrow.style, {
          left: x != null ? `${x}px` : "",
          top: y != null ? `${y}px` : "",
          // Ensure the static side gets unset when
          // flipping to other placements' axes.
          right: "",
          bottom: "",
          [staticSide]: `${-8 / 2}px`,
        });
      }
    })
  }

  showTooltip() {
    this.tooltip.classList.add("open")
    this.updatePosition()
  }

  hideTooltip() {
    this.tooltip.classList.remove("open")
  }

  addEvents() {
    [
      ['mouseenter', this.showTooltip.bind(this)],
      ['mouseleave', this.hideTooltip.bind(this)],
      ['focus', this.showTooltip.bind(this)],
      ['blur', this.hideTooltip.bind(this)],
      ['click', this.hideTooltip.bind(this)],
    ].forEach(([event, listener]) => {
      this.element.addEventListener(event, listener)
    })
  }
}
