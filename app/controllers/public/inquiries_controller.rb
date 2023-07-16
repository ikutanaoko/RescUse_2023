class Public::InquiriesController < ApplicationController
  def new
    @inquiry = Inquiry.new
  end
  
  def create
    @inquiry = Inquiry.new(inquiry_params)
    if @inquiry.save
      flash[:notice] = "お問い合わせを承りました。"
      redirect_to  inquiry_completion_path
    else
      @inquiry_new = Inquiry.new
      render :inew
    end
  end
  
  def completion
    
  end
  
  private
  
  def inquiry_params
    params.require(:inquiry).permit(:name, :contact, :body)
  end
  
  
end
