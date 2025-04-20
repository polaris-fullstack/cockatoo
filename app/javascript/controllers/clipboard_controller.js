import { Controller } from "@hotwired/stimulus"
import ClipboardJS from "clipboard"
import { autoUpdate, autoPlacement, computePosition, offset, arrow } from "@floating-ui/dom"

export default class extends Controller {
  static values = {
    hideTooltipAfter: 1500,
    tooltipPlacement: String,
    tooltipOffset: 6,
    errorMessage: { type: String, default: "Failed!" },
    successMessage: { type: String, default: "Copied!" }
  }

  connect() {
    this.clipboard = new ClipboardJS(this.element)
    this.clipboard.on("success", (e) => this.handleEvent(this.successMessageValue))
    this.clipboard.on("error",   (e) => this.handleEvent(this.errorMessageValue))
  }

  disconnect() {
    this.clearTooltip()
  }

  handleEvent(message) {
    this.clearTooltip()
    this.createTooltipElements(message)
    this.updatePosition()

    this.timeout = setTimeout(() => {
      this.clearTooltip()
    }, this.hideTooltipAfterValue)
  }

  clearTooltip() {
    this.tooltip?.remove()
    clearTimeout(this.timeout)
  }

  createTooltipElements(message) {
    this.tooltip = document.createElement("div")
    this.tooltip.dataset.tooltipTarget = "content"
    this.tooltip.classList.add("tooltip", "open")
    this.tooltip.textContent = message

    this.arrow = document.createElement("div")
    this.arrow.classList.add("arrow")

    this.tooltip.appendChild(this.arrow)
    document.body.appendChild(this.tooltip)
  }

  updatePosition() {
    computePosition(this.element, this.tooltip, {
      middleware: [
        autoPlacement({
          allowedPlacements: (this.tooltipPlacementValue ? [this.tooltipPlacementValue] : undefined),
        }),
        offset(this.tooltipOffsetValue),
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
}
