class ProductsController < ApplicationController

  def index
    @products = Product.order("id DESC")
  end

  def show
    @product = Product.find(params[:id])
    set_page_title "#{@product.title}"
    @page_description = view_context.truncate(@product.description, length: 100 )
  end

  def add_to_cart
    @product = Product.find(params[:id])

    if !current_cart.items.include?(@product)
      current_cart.add_product_to_cart(@product)
      flash[:notice] = "您已成功將#{@product.title}加入購物車"
    else
      flash[:warning] = "您的購物車內已有此商品"
    end

    redirect_to :back

  end

end
