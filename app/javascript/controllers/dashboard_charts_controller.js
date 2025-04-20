import { Controller } from "@hotwired/stimulus"
import Chart from "chart.js/auto"

export default class extends Controller {
  static targets = ["income", "assets", "liabilities", "expenses", "loanAmount", "likelihood"]

  connect() {
    this.renderCharts()
  }

  renderCharts() {
    this.renderBarChart(this.incomeTarget, JSON.parse(this.incomeTarget.dataset.values), "Total Income (AUD)")
    this.renderBarChart(this.assetsTarget, JSON.parse(this.assetsTarget.dataset.values), "Total Assets (AUD)")
    this.renderBarChart(this.liabilitiesTarget, JSON.parse(this.liabilitiesTarget.dataset.values), "Total Liabilities (AUD)")
    this.renderBarChart(this.expensesTarget, JSON.parse(this.expensesTarget.dataset.values), "Total Expenses (AUD)")
    this.renderBarChart(this.loanAmountTarget, JSON.parse(this.loanAmountTarget.dataset.values), "Total Loan Amount (AUD)")
    this.renderBarChart(this.likelihoodTarget, JSON.parse(this.likelihoodTarget.dataset.values), "Approval Likelihood (%)")
  }

  renderBarChart(target, data, label) {
    new Chart(target, {
      type: 'bar',
      data: {
        labels: data.labels,
        datasets: [{
          label: label,
          data: data.values,
          backgroundColor: 'rgba(59, 130, 246, 0.5)',
          borderColor: 'rgba(59, 130, 246, 1)',
          borderWidth: 1
        }]
      },
      options: {
        responsive: true,
        plugins: {
          legend: { display: false }
        },
        scales: {
          y: { beginAtZero: true }
        }
      }
    })
  }
}
