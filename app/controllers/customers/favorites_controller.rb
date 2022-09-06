class Customers::FavoritesController < ApplicationController
  def create
    document = Document.find(params[:document_id])
    @favorite = current_customer.favorites.new(document_id: document.id)
    @favorite.save
    render "replace_btn"
  end
  
  def destroy
    document = Document.find(params[:document_id])
    @favorite = current_customer.favorites.find_by(document_id: document.id)
    @favorite.destroy
    render "replace_btn"
  end
end
