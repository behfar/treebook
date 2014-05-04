class StatusesController < ApplicationController

  # For devise and Rails 4
  before_action :authenticate_user!, only: [:new, :create, :edit, :update]

  # Looks like this line makes sure we fetch the status referred to by :id (which is a number in the URL)
  before_action :set_status, only: [:show, :edit, :update, :destroy]

  # GET /statuses
  # GET /statuses.json
  def index
    @statuses = Status.all
  end

  # GET /statuses/1
  # GET /statuses/1.json
  def show
  end

  # GET /statuses/new
  def new
    @status = Status.new()
  end

  # GET /statuses/1/edit
  def edit
  end

  # POST /statuses
  # POST /statuses.json
  def create
    # What if .save fails? Does the new status get deallocated or will it stay in the statuses list until destroyed?
    @status = current_user.statuses.new(status_params)

    respond_to do |format|
      if @status.save
        format.html { redirect_to @status, notice: 'Status was successfully created.' }
        format.json { render action: 'show', status: :created, location: @status }
      else
        format.html { render action: 'new' }
        format.json { render json: @status.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /statuses/1
  # PATCH/PUT /statuses/1.json
  def update
    # find the status within current user's scope
    @status = current_user.statuses.find(params[:id])

    # :status is a required in params (see status_params below), so we'd get an exception prior to this block
    if !params[:status]
      respond_to do |format|
        format.html { redirect_to @status, notice: 'Nothing to update.' }
        format.json { head :no_content }
        return
      end
    end

    # filter out any potentially malicious user_id injected into our status parameters
    params[:status].delete(:user_id) if params[:status].has_key?(:user_id)

    respond_to do |format|
      if @status.update(status_params)
        format.html { redirect_to @status, notice: 'Status was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @status.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /statuses/1
  # DELETE /statuses/1.json
  def destroy
    @status.destroy
    respond_to do |format|
      format.html { redirect_to statuses_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_status
      @status = Status.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def status_params
      params.require(:status).permit(:first_name, :last_name, :user_id, :content)
      # params.permit(status: [:content, :user_id])[:status]
    end
end
