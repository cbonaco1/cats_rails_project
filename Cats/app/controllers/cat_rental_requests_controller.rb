class CatRentalRequestsController < ApplicationController

  def new
    @request = CatRentalRequest.new
    render :new
  end

  def create
    cat_name_entered = params[:cat_rental_requests][:name]
    cat_to_rent = Cat.find_by_name(cat_name_entered)
    unless cat_to_rent
      #render plain: "Cat name not found"
      flash[:errors] << "Cat name not found!"
      redirect_to new_cat_rental_request_url
    else
      params[:cat_rental_requests][:cat_id] = cat_to_rent.id

      @request = CatRentalRequest.new(request_params)
      if @request.save
        redirect_to cat_rental_request_url(@request)
      else
        render :new
      end
    end
  end

  private

  def request_params
    params.require(:cat_rental_requests).permit(:cat_id, :start_date, :end_date)
  end
end
