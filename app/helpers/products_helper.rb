module ProductsHelper
  # Returns the name of the product seller
  def product_author(product)
    product.user.try(:name) || "Anonymous"
  end

  # Returns true if current signed-in user is the product owner
  def product_author?(product)
    user_signed_in? && current_user == product.user
  end
end

