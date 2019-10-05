class RecordsController < ApplicationController
  before_action :set_record, only: [:edit, :update, :destroy]

  # GET /records/new
  def new
    if params[:zone_id].blank?
      redirect_back fallback_location: zones_path, notice: "We couldn't find the Zone to add the Record to. Please try again."
    else
      @record = Record.new
      @zone = Zone.find(params[:zone_id])
    end
  end

  # GET /records/1/edit
  def edit
    @zone = @record.zone
  end

  # POST /records
  def create
    @record = Record.new(record_params)
    @zone = Zone.find(params['zone_id'])
    @record.zone_id = @zone.id
    response = Ns1::Record.create(
      @zone.zone,
      @zone.zone,
      record_params[:type_of].upcase,
      [{ answer: [record_params[:rdata]] }]
    )
    if response.success?
      json = JSON.parse(response.body)
      ttl = json['ttl']
      if @record.save
        redirect_to @zone, notice: 'Record was successfully created.'
      else
        render :new
      end
    else
      message = 'Something went wrong creating your Record. Please try again shortly.'
      redirect_to new_record_path, notice: message
    end
  end

  # PATCH/PUT /records/1
  def update
    @zone = @record.zone
    response = Ns1::Record.update(
      @zone.zone,
      @zone.zone,
      record_params[:type_of].upcase,
      [{ answer: [record_params[:rdata]] }]
    )
    if response.success?
      json = JSON.parse(response.body)
      ttl = json['ttl']
      if @record.update(record_params)
        redirect_to @zone, notice: 'Record was successfully updated.'
      else
        render :edit
      end
    else
      message = 'Something went wrong updating your Record. Please try again shortly.'
      redirect_to edit_record_path(@record), notice: message
    end
  end

  # DELETE /records/1
  def destroy
    @zone = @record.zone
    response = Ns1::Record.destroy(@zone.zone, @zone.zone, @record.type_of)
    if response.success?
      @record.destroy
      redirect_to @zone, notice: 'Record was successfully destroyed.'
    else
      message = 'Something went wrong destroying your Record. Please try again shortly.'
      redirect_back fallback_location: zones_path, notice: message
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_record
      @record = Record.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def record_params
      params.require(:record).permit(:type_of, :rdata, :zone_id)
    end
end
