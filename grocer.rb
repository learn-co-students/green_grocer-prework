def consolidate_cart(cart)
  new_cart = {}
  cart.each do |items_array|
    items_array.each do |item, price_hash|
      new_cart[item] ||= price_hash
      if new_cart[item][:count]
        new_cart[item][:count] += 1
      else new_cart[item][:count] = 1
      end
    end
  end
  new_cart
end




def apply_coupons(cart, coupons)
  coupons.each do |coupon|
    if cart.keys.include? coupon[:item]
      if cart[coupon[:item]][:count] >= coupon[:num]
        added_name = "#{coupon[:item]} W/COUPON"
        if cart[added_name]
          cart[added_name][:count] += coupon[:num]
        else cart[added_name] = {
          price: coupon[:cost]/ coupon[:num],
          clearance: cart[coupon[:item]][:clearance],
          count: coupon[:num]
        }
      end
      cart[coupon[:item]][:count] -= coupon[:num]
    end
  end
end
cart
end




def apply_clearance(cart)
  cart.keys.each do |item|
    if cart[item][:clearance] == true
      cart[item][:price] = (cart[item][:price]*0.80).round(3)
    end
  end
  cart
end

def checkout(cart, coupons)
  organized_cart = consolidate_cart(cart)
  cart_with_coupons_applied = apply_coupons(organized_cart, coupons)
  cart_with_clearance_applied = apply_clearance(cart_with_coupons_applied)
  total = 0
  cart_with_clearance_applied.keys.each do |item|
    total += cart_with_clearance_applied[item][:price] * cart_with_clearance_applied[item][:count]
  end
  if total > 100
    total = total * 0.90
  else return total
  end



end
