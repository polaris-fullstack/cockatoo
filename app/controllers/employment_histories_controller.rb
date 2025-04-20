class EmploymentHistoriesController < ApplicationController
  before_action :set_employment_history, only: [:show, :edit, :update, :destroy]

  # GET /employment_histories
  def index
    @pagy, @employment_histories = pagy(EmploymentHistory.sort_by_params(params[:sort], sort_direction))
  end

  # GET /employment_histories/1 or /employment_histories/1.json
  def show
  end

  # GET /employment_histories/new
  def new
    @employment_history = EmploymentHistory.new
  end

  # GET /employment_histories/1/edit
  def edit
  end

  # POST /employment_histories or /employment_histories.json
  def create
    @employment_history = EmploymentHistory.new(employment_history_params)

    respond_to do |format|
      if @employment_history.save
        format.html { redirect_to @employment_history, notice: "Employment history was successfully created." }
        format.json { render :show, status: :created, location: @employment_history }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @employment_history.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /employment_histories/1 or /employment_histories/1.json
  def update
    respond_to do |format|
      if @employment_history.update(employment_history_params)
        format.html { redirect_to @employment_history, notice: "Employment history was successfully updated." }
        format.json { render :show, status: :ok, location: @employment_history }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @employment_history.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /employment_histories/1 or /employment_histories/1.json
  def destroy
    @employment_history.destroy!
    respond_to do |format|
      format.html { redirect_to employment_histories_path, status: :see_other, notice: "Employment history was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_employment_history
    @employment_history = EmploymentHistory.find(params.expect(:id))
  rescue ActiveRecord::RecordNotFound
    redirect_to employment_histories_path
  end

  # Only allow a list of trusted parameters through.
  def employment_history_params
    params.expect(employment_history: [ :applicant_id, :employer_name, :address, :state, :postcode, :phone, :occupation, :start_date, :end_date, :employment_type, :accountant_name, :accountant_firm, :accountant_phone ])
  end
end
