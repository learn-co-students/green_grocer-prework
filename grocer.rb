ef consolidate_cart(cart:[])
#code here
end

def apply_single_coupon(cart, coupon)

   coupItem = coupon[:item]

   if cart.keys.include?(coupItem) && cart[coupItem][:count] >= coupon[:num]
    cart[coupItem][:count] = cart[coupItem][:count] - coupon[:num]
    cart["#{coupItem} W/COUPON"] ||= {}
    cart["#{coupItem} W/COUPON"][:price] = coupon[:cost]
    cart["#{coupItem} W/COUPON"][:clearance] = cart[coupItem][:clearance]
    cart["#{coupItem} W/COUPON"][:count] ||= 0
    cart["#{coupItem} W/COUPON"][:count] += 1
  end
end

def apply_coupons(cart: [], coupons: [])
  # code here	  coupons.each do |couponHash|
    apply_single_coupon(cart, couponHash)
  end
  cart
end

def checkout(cart, coupons)
  # code here
end
