import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["purposeSelect", "firstTimeOwner", "fhogEligible"]

  connect() {
    this.toggleFields()
  }

  toggleFields() {
    const value = this.purposeSelectTarget.value
    // Example: Only show first time owner and FHOG fields for 'Purchase of Home'
    const showHomeOwnerFields = value === "Purchase of Home"
    this.firstTimeOwnerTarget.classList.toggle("hidden", !showHomeOwnerFields)
    this.fhogEligibleTarget.classList.toggle("hidden", !showHomeOwnerFields)
  }
}
