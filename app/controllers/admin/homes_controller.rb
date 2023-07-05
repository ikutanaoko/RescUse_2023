class Admin::HomesController < ApplicationController
  def top
    @users = User.all
  end

  def result
  end
end
