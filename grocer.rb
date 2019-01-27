def consolidate_cart(cart)
  newCart = {}
  cart.each do |itemList|
    itemList.each do |key ,item|
      newCart[key] ||= item
      newCart[key][:count] = newCart[key].has_key?(:count) ? newCart[key][:count] + 1 : 1
    end
  end
  newCart
end

def apply_coupons(cart, coupons)
  # code here
end

def apply_clearance(cart)
  # code here
end

def checkout(cart, coupons)
  # code here
end
