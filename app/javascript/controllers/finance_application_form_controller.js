import { Controller } from "@hotwired/stimulus";
// Connects to data-controller="finance-application-form"
// Usage: Add data-action="click->finance-application-form#addNested" and data-target-type="applicant|employment-history|document" to each add button
//        Add data-action="click->finance-application-form#removeNested" and data-target="applicant|employment-history|document" to each remove button
export default class extends Controller {
  static targets = ["tab", "section", "tabButton"];

  connect() {
    this.showTab(0);
  }

  showTab(event) {
    let index = event?.target?.dataset?.index ? parseInt(event.target.dataset.index) : 0;
    this.tabTargets.forEach((tab, i) => {
      tab.classList.toggle("hidden", i !== index);
    });
    this.tabButtonTargets.forEach((btn, i) => {
      btn.classList.toggle("bg-blue-600", i === index);
      btn.classList.toggle("text-white", i === index);
      btn.classList.toggle("bg-gray-200", i !== index);
      btn.classList.toggle("text-blue-600", i !== index);
    });
  }

  toggleSection(event) {
    const section = event.currentTarget.nextElementSibling;
    section.classList.toggle("hidden");
  }

  addNested(event) {
    event.preventDefault();
    const type = event.target.dataset.targetType;
    const container = this.element.querySelector(`[data-nested-container="${type}"]`);
    const prototype = container.dataset.prototype;
    let index = container.dataset.index ? parseInt(container.dataset.index) : container.children.length;
    const newItem = prototype.replace(/__INDEX__/g, index);
    container.insertAdjacentHTML("beforeend", newItem);
    container.dataset.index = index + 1;
  }

  removeNested(event) {
    event.preventDefault();
    const target = event.target.closest('[data-nested-record]');
    if (target) target.remove();
  }
}
