class ApplicationsController < ApplicationController
  before_action :set_application, only: %i[show edit properties_step1 properties_step2 assets_step1 assets_step2 liabilities_step1 applicants_step1 documents_step1 declaration_step1]

  # --- Sidebar Multi-Step Actions ---
  def properties_step1
    @current_step = :properties
    render :edit
  end

  def properties_step2
    if request.patch?
      if @application.update(application_params(:properties))
        redirect_to assets_step1_application_path(@application)
      else
        render :edit, status: :unprocessable_entity
      end
    else
      render :edit
    end
  end

  def assets_step1
    @current_step = :assets
    render :edit
  end

  def assets_step2
    if request.patch?
      if @application.update(application_params)
        redirect_to liabilities_step1_application_path(@application)
      else
        render :edit, status: :unprocessable_entity
      end
    else
      render :edit
    end
  end

  def liabilities_step1
    @current_step = :liabilities
    render :edit
  end

  def applicants_step1
    @current_step = :applicants
    render :edit
  end

  def documents_step1
    @current_step = :documents
    render :edit
  end

  def declaration_step1
    @current_step = :declaration
    render :edit
  end

  private

  def application_params(section = nil)
    case section
    when :loan_details
      params.require(:application).permit(
        :purpose, :first_time_owner, :fhog_eligible, :status
      )
    when :properties
      params.require(:application).permit(properties_attributes: [
        :id, :property_type, :occupancy_type, :address, :property_state, :property_postcode,
        :bedrooms, :bathrooms, :car_spaces, :land_size, :newly_built, :off_the_plan, :strata_title,
        :rental_income, :outstanding_loan_amount, :current_lender, :zoning, :property_usage,
        :property_notes, :title_reference, :lot_number, :estimated_completion_date,
        :construction_type, :floor_area, :valuation_date, :tenanted, :lease_expiry_date,
        :council_rates, :strata_fees, :insurance_details, :energy_rating, :_destroy
      ])
    when :applicants
      params.require(:application).permit(applicants_attributes: [
        :id, :surname, :given_names, :dob, :drivers_licence, :licence_state, :marital_status,
        :dependants, :email, :phone, :address, :address_state, :address_postcode, :residency_status,
        :us_citizen, :tin, :other_tax_countries, :income, :expenses, :_destroy
      ])
    when :documents
      params.require(:application).permit(documents: [])
    else
      params.require(:application).permit(:assets, :liabilities, :superannuation, :other_assets, :declaration)
    end
  end

  # GET /applications
  def index
    @pagy, @applications = pagy(Loan::FinanceApplication.sort_by_params(params[:sort], sort_direction))
  end

  # GET /applications/1 or /applications/1.json
  def show
  end

  # GET /applications/new
  def new
    redirect_to new_loan_details_applications_path
  end
  
  # --- Multi-step New Application Actions ---
  
  # Step 1: Loan Details
  def new_loan_details
    # Ensure we have a valid Loan::FinanceApplication object
    @application = Loan::FinanceApplication.new
    Rails.logger.debug "DEBUG: Simplified @application initialized as: #{@application.inspect}"
    
    # --- Temporarily commented out session logic ---
    # # Initialize session params if needed
    # session[:application_params] ||= {}
    # 
    # # Only assign attributes if there are valid parameters in the session
    # if session[:application_params].present?
    #   begin
    #     filtered_params = session[:application_params].slice(:purpose, :first_time_owner, :fhog_eligible)
    #     Rails.logger.debug "DEBUG: Assigning attributes from session: #{filtered_params.inspect}"
    #     @application.assign_attributes(filtered_params) if filtered_params.present?
    #   rescue => e
    #     # Log the error but continue with a fresh application object
    #     Rails.logger.error "ERROR: Error assigning attributes in new_loan_details: #{e.message}"
    #     @application = Loan::FinanceApplication.new
    #   end
    # end
    # 
    # # Final check to ensure @application is not nil - likely redundant
    # # @application = Loan::FinanceApplication.new if @application.nil?
    # # Rails.logger.debug "DEBUG: Final @application: #{@application.inspect}"
    # --- End of commented out section ---
  end
  
  def create_loan_details
    @application = Loan::FinanceApplication.new(application_params(:loan_details))
    session[:application_params] = application_params(:loan_details).to_h
    
    if params[:save_draft] && @application.valid?(:loan_details)
      @application.status = 'draft'
      if @application.save
        redirect_to edit_application_path(@application), notice: 'Application draft was successfully created.'
      else
        render :new_loan_details, status: :unprocessable_entity
      end
    elsif @application.valid?(:loan_details)
      redirect_to new_applicants_applications_path
    else
      render :new_loan_details, status: :unprocessable_entity
    end
  rescue => e
    # Log the error
    Rails.logger.error("Error in create_loan_details: #{e.message}")
    # Initialize a new application if it's nil
    @application = Loan::FinanceApplication.new
    flash.now[:alert] = "There was an error processing your application. Please try again."
    render :new_loan_details, status: :unprocessable_entity
  end
  
  # Step 2: Applicants
  def new_applicants
    @application = Loan::FinanceApplication.new
    session[:application_params] ||= {}
    @application.assign_attributes(session[:application_params])
  end
  
  def create_applicants
    @application = Loan::FinanceApplication.new(session[:application_params])
    @application.assign_attributes(application_params(:applicants))
    session[:application_params] = session[:application_params].merge(application_params(:applicants).to_h)
    
    if params[:save_draft] && @application.valid?(:applicants)
      @application.status = 'draft'
      if @application.save
        redirect_to edit_application_path(@application), notice: 'Application draft was successfully created.'
      else
        render :new_applicants, status: :unprocessable_entity
      end
    elsif @application.valid?(:applicants)
      redirect_to new_properties_applications_path
    else
      render :new_applicants, status: :unprocessable_entity
    end
  end
  
  # Step 3: Properties
  def new_properties
    @application = Loan::FinanceApplication.new
    session[:application_params] ||= {}
    @application.assign_attributes(session[:application_params])
  end
  
  def create_properties
    @application = Loan::FinanceApplication.new(session[:application_params])
    @application.assign_attributes(application_params(:properties))
    session[:application_params] = session[:application_params].merge(application_params(:properties).to_h)
    
    if params[:save_draft] && @application.valid?(:properties)
      @application.status = 'draft'
      if @application.save
        redirect_to edit_application_path(@application), notice: 'Application draft was successfully created.'
      else
        render :new_properties, status: :unprocessable_entity
      end
    elsif @application.valid?(:properties)
      redirect_to new_assets_applications_path
    else
      render :new_properties, status: :unprocessable_entity
    end
  end
  
  # Step 4: Assets
  def new_assets
    @application = Loan::FinanceApplication.new
    session[:application_params] ||= {}
    @application.assign_attributes(session[:application_params])
  end
  
  def create_assets
    @application = Loan::FinanceApplication.new(session[:application_params])
    @application.assign_attributes(application_params(:assets))
    session[:application_params] = session[:application_params].merge(application_params(:assets).to_h)
    
    if params[:save_draft] && @application.valid?(:assets)
      @application.status = 'draft'
      if @application.save
        redirect_to edit_application_path(@application), notice: 'Application draft was successfully created.'
      else
        render :new_assets, status: :unprocessable_entity
      end
    elsif @application.valid?(:assets)
      redirect_to new_liabilities_applications_path
    else
      render :new_assets, status: :unprocessable_entity
    end
  end
  
  # Step 5: Liabilities
  def new_liabilities
    @application = Loan::FinanceApplication.new
    session[:application_params] ||= {}
    @application.assign_attributes(session[:application_params])
  end
  
  def create_liabilities
    @application = Loan::FinanceApplication.new(session[:application_params])
    @application.assign_attributes(application_params(:liabilities))
    session[:application_params] = session[:application_params].merge(application_params(:liabilities).to_h)
    
    if params[:save_draft] && @application.valid?(:liabilities)
      @application.status = 'draft'
      if @application.save
        redirect_to edit_application_path(@application), notice: 'Application draft was successfully created.'
      else
        render :new_liabilities, status: :unprocessable_entity
      end
    elsif @application.valid?(:liabilities)
      redirect_to new_documents_applications_path
    else
      render :new_liabilities, status: :unprocessable_entity
    end
  end
  
  # Step 6: Documents
  def new_documents
    @application = Loan::FinanceApplication.new
    session[:application_params] ||= {}
    @application.assign_attributes(session[:application_params])
  end
  
  def create_documents
    @application = Loan::FinanceApplication.new(session[:application_params])
    @application.assign_attributes(application_params(:documents))
    session[:application_params] = session[:application_params].merge(application_params(:documents).to_h)
    
    if params[:save_draft] && @application.valid?(:documents)
      @application.status = 'draft'
      if @application.save
        redirect_to edit_application_path(@application), notice: 'Application draft was successfully created.'
      else
        render :new_documents, status: :unprocessable_entity
      end
    elsif @application.valid?(:documents)
      redirect_to new_declaration_applications_path
    else
      render :new_documents, status: :unprocessable_entity
    end
  end
  
  # Step 7: Declaration
  def new_declaration
    @application = Loan::FinanceApplication.new
    session[:application_params] ||= {}
    @application.assign_attributes(session[:application_params])
  end
  
  def create_declaration
    @application = Loan::FinanceApplication.new(session[:application_params])
    @application.assign_attributes(application_params(:declaration))
    
    @application.status = params[:save_draft] ? 'draft' : 'complete'
    
    if @application.save
      # Clear session data after successful save
      session.delete(:application_params)
      redirect_to @application, notice: 'Application was successfully created.'
    else
      render :new_declaration, status: :unprocessable_entity
    end
  end

  # GET /applications/1/edit
  def edit
  end

  # POST /applications or /applications.json
  def create
    @application = Loan::FinanceApplication.new(application_params)
    @application.status = params[:save_draft] ? :draft : :complete

    respond_to do |format|
      if @application.save
        format.html { redirect_to application_url(@application), notice: "Application was successfully created." }
        format.json { render :show, status: :created, location: @application }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @application.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /applications/1 or /applications/1.json
  def update
    step = params[:current_step]&.to_sym
    @application.status = params[:save_draft] ? :draft : :complete

    # Determine permitted params for the current step
    permitted_params = application_params(step)

    respond_to do |format|
      if @application.update(permitted_params)
        # Figure out next step
        if params[:save_draft]
          format.html { redirect_to edit_application_path(@application), notice: "Draft saved." }
        else
          next_step = case step
                      when :loan_details then :applicants_step1
                      when :applicants then :properties_step1
                      when :properties then :assets_step1
                      when :assets then :liabilities_step1
                      when :liabilities then :documents_step1
                      when :documents then :declaration_step1
                      when :declaration then :show
                      else :edit
                      end
          if next_step == :show
            format.html { redirect_to @application, notice: "Application was successfully submitted!" }
          else
            format.html { redirect_to url_for(action: next_step, id: @application.id), notice: "Step saved. Continue to next section." }
          end
        end
        format.json { render :show, status: :ok, location: @application }
      else
        @current_step = step
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @application.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /applications/1 or /applications/1.json
  def destroy
    @application = Loan::FinanceApplication.find(params[:id])
    @application.destroy

    respond_to do |format|
      format.html { redirect_to applications_url, notice: "Application was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  def remove_document
    @application = Loan::FinanceApplication.find(params[:id])
    document = @application.documents.find_signed(params[:document_id])
    document.purge
    redirect_to edit_application_path(@application), notice: 'Document was successfully removed.'
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_application
    @application = Loan::FinanceApplication.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    redirect_to applications_path
  end

  # Only allow a list of trusted parameters through.
  def application_params(section = nil)
    case section
    when :loan_details
      params.require(:finance_application).permit(:purpose, :loan_amount, :repayment_type, :fixed_rate_term, :property_value, :first_time_owner, :owner_occupier, :investment_property, :first_home_owner_grant, :construction_loan, :refinance_loan)
    when :applicants
      params.require(:finance_application).permit(applicants_attributes: [
        :id, :title, :surname, :given_names, :dob, :drivers_licence, :licence_state, :marital_status, :dependants, :email, :phone, :address, :address_state, :address_postcode, :residency_status, :us_citizen, :tin, :other_tax_countries, :_destroy,
        employment_histories_attributes: [
          :id, :employer_name, :address, :state, :postcode, :phone, :occupation, :start_date, :end_date, :employment_type, :accountant_name, :accountant_firm, :accountant_phone, :_destroy
        ],
        documents_attributes: [
          :id, :document_type, :file, :_destroy
        ]
      ])
    when :properties
      params.require(:finance_application).permit(properties_attributes: [
        :id, :property_type, :occupancy_type, :address, :property_state, :property_postcode,
        :bedrooms, :bathrooms, :car_spaces, :land_size, :newly_built, :off_the_plan, :strata_title,
        :rental_income, :outstanding_loan_amount, :current_lender, :zoning, :property_usage,
        :property_notes, :title_reference, :lot_number, :estimated_completion_date,
        :construction_type, :floor_area, :valuation_date, :tenanted, :lease_expiry_date,
        :council_rates, :strata_fees, :insurance_details, :energy_rating, :_destroy
      ])
    when :assets
      params.require(:finance_application).permit(:assets)
    when :liabilities
      params.require(:finance_application).permit(:liabilities)
    when :documents
      params.require(:finance_application).permit(:identity_document, :income_document, :bank_statement, :assets_document, :liabilities_document, :purchase_contract, :rates_notice, :rental_income)
    when :declaration
      params.require(:finance_application).permit(:declaration)
    else
      params.require(:finance_application).permit(
        :purpose, :first_time_owner, :fhog_eligible, :property_address, :property_state, :property_postcode, :purchase_price, :dwelling_age, :assets, :liabilities, :income, :expenses, :declaration,
        applicants_attributes: [
          :id, :title, :surname, :given_names, :dob, :drivers_licence, :licence_state, :marital_status, :dependants, :email, :phone, :address, :address_state, :address_postcode, :residency_status, :us_citizen, :tin, :other_tax_countries, :_destroy,
          employment_histories_attributes: [
            :id, :employer_name, :address, :state, :postcode, :phone, :occupation, :start_date, :end_date, :employment_type, :accountant_name, :accountant_firm, :accountant_phone, :_destroy
          ],
          documents_attributes: [
            :id, :document_type, :file, :_destroy
          ]
        ]
      )
    end
  end
end
