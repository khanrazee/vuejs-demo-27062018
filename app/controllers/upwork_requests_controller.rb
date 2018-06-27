class UpworkRequestsController < ApplicationController

  before_action :set_upwork_request, only: [:update, :destroy]

  def index
    @upwork_requests = UpworkRequest.all
    respond_to do |format|
      format.html
      format.json { render :json => @upwork_requests }
    end
  end

  def create
    @upwork_request = UpworkRequest.new(upwork_request_params)
    respond_to do |format|
      format.json do 
        if @upwork_request.save
          render :json => @upwork_request
        else
          render :json => { :errors => @upwork_request.errors.messages }, :status => 422
        end
      end
    end
  end

  def update
    respond_to do |format|
      format.json do 
        if @upwork_request.update(upwork_request_params)
          render :json => @upwork_request
        else
          render :json => { :errors => @upwork_request.errors.messages }, :status => 422
        end
      end
    end
  end

  def destroy
    @upwork_request.destroy
    respond_to do |format|
      format.json { render :json => {}, :status => :no_content }
    end
  end

  private

  def set_upwork_request
    @upwork_request = UpworkRequest.find(params[:id])
  end

  def upwork_request_params
    params.require(:upwork_request).permit(:name, :email, :profile_url, :message)
  end
end
