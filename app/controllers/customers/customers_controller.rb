class Customers::CustomersController < ApplicationController
  before_action :authenticate_customer!
  before_action :set_customer
  before_action :correct_user, only: [:show, :edit, :update]
  before_action :correct_customer, only: [:confirm, :withdrawal]
  before_action :ensure_guest_user, only: [:edit, :update]
  before_action :check_guest_user, only: [:confirm, :withdrawal]

  def show
    @documents = @customer.documents
  end

  def edit
  end

  def update
    if @customer.update(customer_params)
      flash[:notice] = "編集内容を保存しました"
      redirect_to customer_path(@customer)
    else
      flash[:alert] = "20文字以上のユーザー名、または入力がされていないようです"
      render :edit
    end
  end

  def confirm
  end

  def withdrawal
    @customer.update(is_deleted: true)
    reset_session
    flash[:notice] = "退会手続きが完了しました 「myiconic」をご利用いただき、ありがとうございました"
    redirect_to root_path
  end

  def favorites
    @favorites = current_customer.favorites.pluck(:document_id)
    favorite_list = Document.find(@favorites)
    @favorite_list = Kaminari.paginate_array(favorite_list).page(params[:page])
  end

  private
    def customer_params
      params.require(:customer).permit(:name, :profile_image)
    end

    def set_customer
      @customer = current_customer
    end
    
    def correct_user
      @customer = Customer.find(params[:id])
      if current_customer != @customer
        flash[:alert] = "他ユーザーのマイページ機能は使えません"
        redirect_to customer_path(current_customer)
      end
    end
    
    def correct_customer
      @customer = Customer.find(params[:customer_id])
      if current_customer != @customer
        flash[:alert] = "他ユーザーの退会機能は使えません"
        redirect_to customer_path(current_customer)
      end
    end

    def ensure_guest_user
      @customer = Customer.find(params[:id])
      if @customer.name == "guestuser"
        flash[:alert] = "ゲストユーザーはプロフィール編集機能が使えません"
        redirect_to customer_path(current_customer)
      end
    end

    def check_guest_user
      @customer = Customer.find(params[:customer_id])
      if @customer.name == "guestuser"
        flash[:alert] = "ゲストユーザーは退会機能が使えません"
        redirect_to customer_path(current_customer)
      end
    end
end
