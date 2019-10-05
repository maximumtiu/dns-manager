class ZonesController < ApplicationController
  before_action :set_zone, only: [:show, :edit, :update, :destroy]

  # GET /zones
  # GET /zones.json
  def index
    @zones = Zone.all
  end

  # GET /zones/1
  # GET /zones/1.json
  def show
  end

  # GET /zones/new
  def new
    @zone = Zone.new
  end

  # GET /zones/1/edit
  def edit
  end

  # POST /zones
  # POST /zones.json
  def create
    @zone = Zone.new(zone_params)
    response = Ns1::Zone.create(zone_params[:zone])
    if response.success?
      json = JSON.parse(response.body)
      @zone.dns_servers = json['dns_servers']

      respond_to do |format|
        if @zone.save
          format.html { redirect_to @zone, notice: 'Zone was successfully created.' }
          format.json { render :show, status: :created, location: @zone }
        else
          format.html { render :new }
          format.json { render json: @zone.errors, status: :unprocessable_entity }
        end
      end
    else
      message = 'Something went wrong creating your Zone. Please try again shortly.'
      respond_to do |format|
        format.html { redirect_to new_zone_path, notice: message }
        format.json { render json: { error: message }, status: 500 }
      end
    end
  end

  # DELETE /zones/1
  # DELETE /zones/1.json
  def destroy
    response = Ns1::Zone.destroy(@zone.zone)
    if response.success?
      @zone.destroy
      respond_to do |format|
        format.html { redirect_to zones_path, notice: 'Zone was successfully destroyed.' }
        format.json { head :no_content }
      end
    else
      message = 'Something went wrong destroying your Zone. Please try again shortly.'
      respond_to do |format|
        format.html { redirect_back fallback_location: zones_path, notice: message }
        format.json { render json: { error: message }, status: 500 }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_zone
      @zone = Zone.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def zone_params
      params.require(:zone).permit(:zone, :dns_servers)
    end
end
