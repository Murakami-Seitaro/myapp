class Admins::HomesController < ApplicationController
  before_action :authenticate_admin!

  def top
    @customers = Customer.all.page(params[:page]).per(12)
  end
end
