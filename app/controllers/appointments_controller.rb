class AppointmentsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_patient, only: [:create, :show, :edit, :update, :destroy]
  before_action :set_appointment, only: [:show, :edit, :update, :destroy]

  # GET /appointments
  # GET /appointments.json
  def index
    @appointments = @patient.appointments
  end

  def today
    @appointments = compute_appointments(Time.now)

    render :index
  end

  def compute_appointments(date)
    date = date.in_time_zone(Time.zone)
    to = date.beginning_of_day
    from = date.end_of_day
    Appointment.where("starts_at between ? and ?", to, from)
  end

  def search
    @appointments = compute_appointments(date)

    render :index
  end

  # GET /appointments/1
  # GET /appointments/1.json
  def show
    if params[:key]
      @appointment.attachments.create(key: params[:key])
      redirect_to [@patient, @appointment], notice: 'Document was successfully created.'
    end

    @file = @appointment.attachments.build.document
    @file.success_action_redirect = patient_appointment_url(@patient, @appointment)
  end

  # GET /appointments/new
  def new
    @appointment = @patient.appointments.build
    @appointment.attachments.build
  end

  # GET /appointments/1/edit
  def edit
  end

  # POST /appointments
  # POST /appointments.json
  def create
    time = compute_appointments(Time.now).maximum(:starts_at)
    @appointment = @patient.appointments.build(starts_at: (time + 10.minutes))

    respond_to do |format|
      if @appointment.save
        format.html { redirect_to @appointment.patient, notice: 'Appointment was successfully created.' }
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
        format.html { redirect_to @appointment, notice: 'Appointment was successfully updated.' }
        format.json { render :show, status: :ok, location: @appointment }
      else
        format.html { render :edit }
        format.json { render json: @appointment.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /appointments/1
  # DELETE /appointments/1.json
  def destroy
    @appointment.destroy
    respond_to do |format|
      format.html { redirect_to appointments_url, notice: 'Appointment was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    def set_patient
      @patient = Patient.find(params[:patient_id])
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_appointment
      @appointment = @patient.appointments.find(params[:id])
    end


    # Never trust parameters from the scary internet, only allow the white list through.
    def appointment_params
      params.require(:appointment).permit(:starts_at, :patient_id, attachments_attributes: [:file, :_destroy])
    end
end
