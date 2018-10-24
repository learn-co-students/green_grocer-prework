def consolidate_cart(cart)
  # code here
end

def apply_coupons(cart, coupons)
  # code here
end

def apply_clearance(cart)
  # code here
end

def checkout(cart, coupons)
  total = 0 
  new_cart = apply_coupons(consolidate_cart(cart), coupons)
  new_cart = apply_clearance(new_cart)
end
end 
total
end

