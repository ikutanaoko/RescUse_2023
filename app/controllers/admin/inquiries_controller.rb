class Admin::InquiriesController < ApplicationController
  
  def update
    inquiry = Inquiry.find(params[:id])
    if inquiry.checked == false 
      inquiry.update(checked: true)
      redirect_to admin_path
    else
      inquiry.update(checked: false)
      redirect_to admin_path
    end
  end
  
end
