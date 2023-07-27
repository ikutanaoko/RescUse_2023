class Public::InquiriesController < ApplicationController
  def new
    @inquiry = Inquiry.new
  end
  
  
  def completion
    @inquiry = Inquiry.new(inquiry_params)
    #保存された場合は内容を表示する
    if @inquiry.save
      flash[:notice] = "下記内容にてお問い合わせを承りました。"
      @name = @inquiry.name
      @contact = @inquiry.contact
      @body = @inquiry.body
    #保存されない場合はフォームがある画面を表示
    else
      @inquiry_new = Inquiry.new
      render :new
    end
  end
  
  private
  
  def inquiry_params
    params.require(:inquiry).permit(:name, :contact, :body, :checked)
  end
  
  
end
