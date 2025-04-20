import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = [
    "landSize", "rentalIncome", "outstandingLoan", "currentLender", "zoning", "propertyUsage",
    "titleReference", "lotNumber", "estimatedCompletionDate", "constructionType", "floorArea", "valuationDate",
    "tenanted", "leaseExpiryDate", "councilRates", "strataFees", "insuranceDetails", "energyRating",
    "strataTitle", "offThePlan"
  ]

  connect() {
    this.update()
  }

  update() {
    const type = this.element.querySelector('[name*="[property_type]"]').value
    const occupancy = this.element.querySelector('[name*="[occupancy_type]"]').value
    const tenanted = this.element.querySelector('[name*="[tenanted]"]')?.value

    // Title Reference & Lot Number: show for Land Only, Off-the-plan, Rural, Commercial
    if (["Land Only", "Off-the-plan", "Rural", "Commercial"].includes(type)) {
      this.showTarget("titleReference")
      this.showTarget("lotNumber")
    } else {
      this.hideTarget("titleReference")
      this.hideTarget("lotNumber")
    }

    // Estimated Completion Date: only for Off-the-plan
    if (type === "Off-the-plan") {
      this.showTarget("estimatedCompletionDate")
      this.showTarget("offThePlan")
    } else {
      this.hideTarget("estimatedCompletionDate")
      this.hideTarget("offThePlan")
    }

    // Construction Type: show for House, Townhouse, Villa, Dual Occupancy, Off-the-plan
    if (["House", "Townhouse", "Villa", "Dual Occupancy", "Off-the-plan"].includes(type)) {
      this.showTarget("constructionType")
    } else {
      this.hideTarget("constructionType")
    }

    // Floor Area: show for Apartment/Unit, Commercial, Off-the-plan
    if (["Apartment/Unit", "Commercial", "Off-the-plan"].includes(type)) {
      this.showTarget("floorArea")
    } else {
      this.hideTarget("floorArea")
    }

    // Valuation Date: always show
    this.showTarget("valuationDate")

    // Tenanted: show for Investment
    if (occupancy === "Investment") {
      this.showTarget("tenanted")
    } else {
      this.hideTarget("tenanted")
    }

    // Lease Expiry Date: only if tenanted is Yes
    if (tenanted === "true" || tenanted === true) {
      this.showTarget("leaseExpiryDate")
    } else {
      this.hideTarget("leaseExpiryDate")
    }

    // Council Rates: show for all except Commercial
    if (type !== "Commercial") {
      this.showTarget("councilRates")
    } else {
      this.hideTarget("councilRates")
    }

    // Strata Fees: show for Apartment/Unit, Townhouse, Villa, Off-the-plan
    if (["Apartment/Unit", "Townhouse", "Villa", "Off-the-plan"].includes(type)) {
      this.showTarget("strataFees")
      this.showTarget("strataTitle")
    } else {
      this.hideTarget("strataFees")
      this.hideTarget("strataTitle")
    }

    // Insurance Details: always show
    this.showTarget("insuranceDetails")

    // Energy Rating: show for House, Apartment/Unit, Townhouse, Villa, Off-the-plan
    if (["House", "Apartment/Unit", "Townhouse", "Villa", "Off-the-plan"].includes(type)) {
      this.showTarget("energyRating")
    } else {
      this.hideTarget("energyRating")
    }

    // Land Size: show for Land Only, Rural, Commercial, Dual Occupancy
    if (["Land Only", "Rural", "Commercial", "Dual Occupancy"].includes(type)) {
      this.showTarget("landSize")
      this.showTarget("zoning")
      this.showTarget("propertyUsage")
    } else {
      this.hideTarget("landSize")
      this.hideTarget("zoning")
      this.hideTarget("propertyUsage")
    }

    // Rental Income: show for Investment
    if (occupancy === "Investment") {
      this.showTarget("rentalIncome")
    } else {
      this.hideTarget("rentalIncome")
    }

    // Refinancing fields: show for Owner Occupied/Investment + if outstanding loan is relevant
    if (["Owner Occupied", "Investment"].includes(occupancy)) {
      this.showTarget("outstandingLoan")
      this.showTarget("currentLender")
    } else {
      this.hideTarget("outstandingLoan")
      this.hideTarget("currentLender")
    }
  }

  showTarget(target) {
    if (this.hasTarget(target)) {
      this[`${target}Target`].classList.remove("hidden")
    }
  }

  hideTarget(target) {
    if (this.hasTarget(target)) {
      this[`${target}Target`].classList.add("hidden")
    }
  }
}
