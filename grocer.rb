def consolidate_cart(cart)
  hash = {}
  cart.each do |data|
    data.each do |item, info|
      hash[item] = info
      hash[item][:count] = cart.count {|i| i == data}
    end
  end
  hash
end

def apply_coupons(cart, coupons)
  coupons.map do |coupon|
    if cart.has_key?(coupon[:item]) && cart[coupon[:item]][:count] >= coupon[:num]
      if cart["#{coupon[:item]} W/COUPON"]
        cart["#{coupon[:item]} W/COUPON"][:count] += 1
      else
        cart["#{coupon[:item]} W/COUPON"] = {:price => coupon[:cost],
        :clearance => cart[coupon[:item]][:clearance], :count => 1}
      end
      cart[coupon[:item]][:count] = cart[coupon[:item]][:count] - coupon[:num]
    end
  end
  cart
end

def apply_clearance(cart)
  cart.each do |item, info|
    if info[:clearance] == true
      info[:price] = (info[:price] * 0.8).round(1)
    end
  end
  cart
end

def checkout(cart, coupons)
  consCart = consolidate_cart(cart)
  appCoupon = apply_coupons(consCart, coupons)
  outCart = apply_clearance(appCoupon)
  cartTotal =0
  outCart.each do |item, info|
    cartTotal += info[:price] * info[:count]
  end
  if cartTotal > 100
    cartTotal = cartTotal * 0.9
  end
  cartTotal
end
