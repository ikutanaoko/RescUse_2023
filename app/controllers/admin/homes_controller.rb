class Admin::HomesController < ApplicationController
  def top
    @users = User.all
  end

  def search
    
  end
end
