class Public::HomesController < ApplicationController
  before_action :authenticate_user!, only: [:index]
  def top
  end

  def about
  end

  def index
  end
end
