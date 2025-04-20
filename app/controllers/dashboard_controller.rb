class DashboardController < ApplicationController
  def show
    @applications = Loan::FinanceApplication.all
    if params[:state].present?
      @applications = @applications.where(property_state: params[:state])
    end
    if params[:from].present?
      @applications = @applications.where('created_at >= ?', params[:from])
    end
    if params[:to].present?
      @applications = @applications.where('created_at <= ?', params[:to])
    end

    @total_income = @applications.sum(:income)
    @total_assets = @applications.map { |fa| fa.assets.to_f }.sum
    @total_liabilities = @applications.map { |fa| fa.liabilities.to_f }.sum
    @total_expenses = @applications.sum(:expenses)
    @total_loan_amount = @applications.sum(:loan_amount)
    @avg_likelihood_of_approval = @applications.average(:likelihood_of_approval)
    @applications_count = @applications.count

    # Chart data: group by month for trend charts
    if @applications.any?
      @income_chart = chart_data(@applications, :income)
      @assets_chart = chart_data(@applications, :assets, :float)
      @liabilities_chart = chart_data(@applications, :liabilities, :float)
      @expenses_chart = chart_data(@applications, :expenses)
      @loan_amount_chart = chart_data(@applications, :loan_amount)
      @likelihood_chart = chart_data(@applications, :likelihood_of_approval, :float, percent: true)
    else
      months = 5.downto(0).map { |i| (Time.zone.now - i.months).strftime('%Y-%m') }
      zeroes = Array.new(6, 0)
      @income_chart = { labels: months, values: zeroes }
      @assets_chart = { labels: months, values: zeroes }
      @liabilities_chart = { labels: months, values: zeroes }
      @expenses_chart = { labels: months, values: zeroes }
      @loan_amount_chart = { labels: months, values: zeroes }
      @likelihood_chart = { labels: months, values: zeroes }
    end

    # For CSV export
    @export_data = @applications
  end

  private

  def chart_data(scope, field, cast_type = :integer, percent: false)
    grouped = scope.group_by { |fa| fa.created_at.strftime('%Y-%m') }
    labels = grouped.keys.sort
    values = labels.map do |label|
      arr = grouped[label].map { |fa| fa.send(field) }
      arr = arr.map { |v| cast_type == :float ? v.to_f : v.to_i }
      avg = arr.sum / arr.size.to_f rescue 0
      percent ? (avg * 100.0) : avg
    end
    { labels: labels, values: values }
  end
end
