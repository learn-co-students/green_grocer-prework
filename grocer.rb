def consolidate_cart(cart)
  result = {}

  cart.each do |item|
    item.each do |item_name, item_stats|
      if result.has_key?(item_name)
        result[item_name][:count] += 1
      else
        result[item_name] = item_stats
        result[item_name][:count] = 1
      end
    end
  end
  result
end

def apply_coupons(cart, coupons)
  result = cart

  return cart if coupons.length == 0

  coupons.each do |coupon|
    coupon_name = coupon[:item]
    if result.has_key?(coupon_name) && result[coupon_name][:count] >= coupon[:num]
      result[coupon_name][:count] -= coupon[:num]
      coupon_key = "#{coupon_name} W/COUPON"
      if result.has_key?(coupon_key)
        result[coupon_key][:count] += 1 
      else
        result[coupon_key] = {
          :price => coupon[:cost],
          :clearance => result[coupon_name][:clearance],
          :count => 1
        }
      end
    end
  end
  result
end

def apply_clearance(cart)
  result = cart
  result.each do |item_name, item_stats|
    if item_stats[:clearance]
      percentage = item_stats[:price].to_f * 0.2
      item_stats[:price] -= percentage
    end
  end
  result
end

def checkout(cart, coupons)
  consolidated_cart = consolidate_cart(cart)
  applied_coupons = apply_coupons(consolidated_cart, coupons)
  applied_clearance = apply_clearance(applied_coupons)

  total = 0
  applied_clearance.each do |item_name, item_stats|
    item_total = item_stats[:price] * item_stats[:count]
    total += item_total
  end

  if total > 100
    discount = total * 0.1
    return total - discount
  else
    return total
  end
end
