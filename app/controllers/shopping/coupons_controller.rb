class Shopping::CouponsController < ApplicationController
  def show
    form_info
  end

  def create
    @coupon = Coupon.find_by_code(params[:coupon][:code])

    if @coupon && @coupon.eligible? && update_order_coupon_id(@coupon.id)
      flash[:notice] = "Successfully added coupon code #{@coupon.code}."
      redirect_to shopping_orders_url
    else
      form_info
      flash[:notice] = "Sorry coupon code: #{params[:coupon][:code]} is not valid."
      render :action => 'show'
    end
  end

  private

  def form_info
    @coupon = Coupon.new
  end

  def update_order_coupon_id(id)
    session_order.update_attributes(
                          :coupon_id => id
                                    )
  end
end
