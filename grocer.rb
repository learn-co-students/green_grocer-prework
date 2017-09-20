def consolidate_cart(cart)
  # code here
  con_cart = {}
  cart.each do |hash|
    hash.each do |key, values|
      if !con_cart[key]
        con_cart[key] = values
        con_cart[key][:count] = 0
      end
      con_cart[key][:count] += 1
    end
  end
  con_cart
end

def apply_coupons(cart, coupons)
  # code here
  coupons.each do |coupon|
    key = coupon[:item]
    new_key = key + " W/COUPON"

    if cart.key?(key) && cart[key][:count] >= coupon[:num]
      if cart[new_key]
        cart[new_key][:count] += 1
      else
        cart[new_key] = {}
        cart[new_key][:count] = 1
        cart[new_key][:price] = coupon[:cost]
        cart[new_key][:clearance] = cart[key][:clearance]
      end
      cart[key][:count] -= coupon[:num]
    end
  end
  cart
end

def apply_clearance(cart)
  # code here
  cart.each do |item, values|
    if values[:clearance]
      values[:price] = (values[:price] * 0.8).round(2)
    end
  end
  cart
end

def checkout(cart, coupons)
  # code here
  total = 0

  consolidated = consolidate_cart(cart)
  couponed = apply_coupons(consolidated, coupons)
  final =  apply_clearance(couponed)

  final.each do |item, values|
    total += values[:price] * values[:count]
  end
  total = total*0.9 if total > 100
  total
end
