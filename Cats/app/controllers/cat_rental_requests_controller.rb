class CatRentalRequestsController < ApplicationController

  def new
    @request = CatRentalRequest.new
    render :new
  end

  def create
    @request = CatRentalRequest.new(request_params)
    if @request.save
      redirect_to cat_rental_request_url(@request)
    else
      render :new
    end
  end

  def show
    @request = CatRentalRequest.find(params[:id])
    @cat = @request.cat
  end

  def denied?
    self.status == "DENIED"
  end

  def approved?
    self.status == "APPROVED"
  end

  def pending?
    self.status == "PENDING"
  end

  def deny
    current_cat_rental_request.deny!
    redirect_to cat_url(current_cat)
  end

  def approve
    current_cat_rental_request.approve!
    redirect_to cat_url(current_cat)
  end

  private

  def request_params
    params.require(:cat_rental_requests).permit(:cat_id, :start_date, :end_date)
  end

  def current_cat_rental_request
    @rental_request ||= CatRentalRequest.includes(:cat).find(params[:id])
  end

  def current_cat
    #Dont actually run a SELECT query here bc of includes in current_cat_rental_request
    current_cat_rental_request.cat
  end
end
