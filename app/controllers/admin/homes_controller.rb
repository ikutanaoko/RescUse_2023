class Admin::HomesController < ApplicationController
  before_action :authenticate_admin!
  
  def top
    @inquiries = Inquiry.page(params[:page])
  end


end
