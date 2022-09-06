class Customers::DocumentsController < ApplicationController
  before_action :authenticate_customer!
  before_action :set_document, only: [:show, :edit, :update, :destroy]
  before_action :set_tags, only: [:new, :create, :index, :edit, :update, :tag_search]

  def new
    @document_new = Document.new
  end

  def create
    @document_new = Document.new(document_params)
    @document_new.customer_id = current_customer.id
    tag_list = params[:document][:tag_name].split(",")
    if @document_new.save
      @document_new.save_tags(tag_list)
      flash[:notice] = "記録を登録しました"
      redirect_to documents_path
    else
      @document_new = Document.new
      flash[:alert] = "記録の詳細が入力されていないようです"
      render :new
    end
  end

  def index
    @documents = current_customer.documents.includes(:customer).all.order("created_at DESC").page(params[:page])
  end

  def show
  end

  def edit
    @tag_list = @document.tags.pluck(:name).join(",")
  end

  def update
    tag_list = params[:document][:tag_name].split(",")
    if @document.update(document_params)
      @document.save_tags(tag_list)
      flash[:notice] = "編集内容を保存しました"
      redirect_to document_path(params[:id])
    else
      flash[:alert] = "記録の詳細が入力されていないようです"
      render :edit
    end
  end

  def destroy
    @document.destroy
    flash[:notice] = "記録を削除しました"
    redirect_to documents_path
  end

  def word_search
    @words_search = current_customer.documents.includes(:customer).word_search(params[:keyword]).page(params[:page])
  end

  def tag_search
    @tag = Tag.find(params[:tag_id])
    @tags_search = @tag.documents.includes(:customer).where(customer_id: current_customer.id).page(params[:page])
  end

  private
    def document_params
      params.require(:document).permit(:content, :feeling)
    end

    def set_document
      @document = current_customer.documents.find(params[:id])
    end

    def set_tags
      arr = []
      current_customer.documents.each do |doc|
        doc.tags.each do |tag|
          arr.push(tag.id)
        end
      end
      @tags = Tag.where(id: arr).distinct
    end
end
