class Admins::CustomersController < ApplicationController
  before_action :authenticate_admin!
  before_action :set_customer, only: [:show, :edit, :update]

  def show
  end

  def edit
  end

  def update
    if @customer.update(customer_params)
      flash[:notice] = "ユーザー情報が更新されました"
      redirect_to admin_customer_path(@customer)
    else
      flash[:alert] = "20文字以内の名前、メールアドレスが正しく入力されているか もう一度ご確認下さい"
      render :edit
    end
  end

  def word_search
    @customers_search = Customer.word_search(params[:keyword]).page(params[:page]).per(12)
  end

  private
    def customer_params
      params.require(:customer).permit(:name, :email, :is_deleted)
    end

    def set_customer
      @customer = Customer.find(params[:id])
    end
end
