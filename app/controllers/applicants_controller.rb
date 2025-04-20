class ApplicantsController < ApplicationController
  before_action :set_applicant, only: [:show, :edit, :update, :destroy]

  # GET /applicants
  def index
    @pagy, @applicants = pagy(Applicant.sort_by_params(params[:sort], sort_direction))
  end

  # GET /applicants/1 or /applicants/1.json
  def show
  end

  # GET /applicants/new
  def new
    @applicant = Applicant.new
  end

  # GET /applicants/1/edit
  def edit
  end

  # POST /applicants or /applicants.json
  def create
    @applicant = Applicant.new(applicant_params)

    respond_to do |format|
      if @applicant.save
        format.html { redirect_to @applicant, notice: "Applicant was successfully created." }
        format.json { render :show, status: :created, location: @applicant }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @applicant.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /applicants/1 or /applicants/1.json
  def update
    respond_to do |format|
      if @applicant.update(applicant_params)
        format.html { redirect_to @applicant, notice: "Applicant was successfully updated." }
        format.json { render :show, status: :ok, location: @applicant }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @applicant.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /applicants/1 or /applicants/1.json
  def destroy
    @applicant.destroy!
    respond_to do |format|
      format.html { redirect_to applicants_path, status: :see_other, notice: "Applicant was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_applicant
    @applicant = Applicant.find(params.expect(:id))
  rescue ActiveRecord::RecordNotFound
    redirect_to applicants_path
  end

  # Only allow a list of trusted parameters through.
  def applicant_params
    params.expect(applicant: [ :finance_application_id, :title, :surname, :given_names, :dob, :drivers_licence, :licence_state, :marital_status, :dependants, :email, :phone, :address, :address_state, :address_postcode, :residency_status, :us_citizen, :tin, :other_tax_countries ])
  end
end
