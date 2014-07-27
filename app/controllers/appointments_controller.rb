class AppointmentsController < ApplicationController


  before_action :set_patient, only: [:create, :new]
  before_action :set_appointment, only: [:show, :edit, :update, :destroy, :completed]
  before_action :authenticate_user!
  # GET /appointments
  # GET /appointments.json
  def index
    @appointments = @patient.appointments.active
  end

  def today
    @appointments = Appointment.on(Date.today).send(params[:type])

    render :index
  end

  def search
    @appointments = Appointment.on(Date.today)

    render :index
  end

  # GET /appointments/1
  # GET /appointments/1.json
  def show
  end

  # GET /appointments/new
  def new
    @appointment = @patient.appointments.build
    @appointment.attachments.build
  end

  # GET /appointments/1/edit
  def edit
    if params[:key]
      @appointment.attachments.create(key: params[:key])
      redirect_to [:edit,  @appointment], notice: 'Document was successfully created.'
    end

    @file = @appointment.attachments.build.document
    @file.success_action_redirect = edit_appointment_url(@appointment)
  end

  # POST /appointments
  # POST /appointments.json
  def create
    @appointment = @patient.appointments.build(appointment_params)

    @appointment.starts_at ||= Appointment.next

    respond_to do |format|
      if @appointment.save
        format.html { redirect_to today_appointments_path(type: 'active'), notice: 'Appointment was successfully created.' }
        format.json { render :show, status: :created, location: @appointment }
      else
        format.html { render :new }
        format.json { render json: @appointment.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /appointments/1
  # PATCH/PUT /appointments/1.json
  def update
    respond_to do |format|
      if @appointment.update(appointment_params)
        format.html { redirect_to @appointment.patient, notice: 'Appointment was successfully updated.' }
        format.json { render :show, status: :ok, location: @appointment }
      else
        format.html { render :edit }
        format.json { render json: @appointment.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /appointments/1
  # DELETE /appointments/1.json
  def completed
    @appointment.completed!
    respond_to do |format|
      format.html { redirect_to today_appointments_path(type: 'active'), notice: 'Appointment was successfully completed.' }
      format.json { head :no_content }
    end
  end

  # DELETE /appointments/1
  # DELETE /appointments/1.json
  def destroy
    @appointment.destroy
    respond_to do |format|
      format.html { redirect_to today_appointments_path(type: 'active'), notice: 'Appointment was successfully removed.' }
      format.json { head :no_content }
    end
  end

  private
    def set_patient
      @patient = Patient.find(params[:patient_id])
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_appointment
      @appointment = Appointment.find(params[:id])
    end


    # Never trust parameters from the scary internet, only allow the white list through.
    def appointment_params
      params.require(:appointment).permit(:starts_at, :blood_pressure, :weight_in_kgs, :height_in_cms, :notes, :prescription, :patient_id, :starts_at)
    end
end
