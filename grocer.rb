def consolidate_cart(cart)
  consolidated = {}
  cart.each do |item_hash|
    item_hash.each do |item, info_hash|
      if consolidated[item] == nil
         consolidated[item] = info_hash
         consolidated[item][:count] = 1
      else
        consolidated[item][:count] += 1
      end
    end
  end
  consolidated
end

def apply_coupons(cart, coupons)
  coupons.each do |coupon_hash|
    coupon_item = coupon_hash[:item]
    if cart.keys.include?("#{coupon_item} W/COUPON") && cart[coupon_item][:count] >= coupon_hash[:num]
      cart[coupon_item][:count] -= coupon_hash[:num]
      cart["#{coupon_item} W/COUPON"][:count] += 1
    elsif cart.keys.include?(coupon_item) && cart[coupon_item][:count] >= coupon_hash[:num]
      cart["#{coupon_item} W/COUPON"] = {price: coupon_hash[:cost], clearance: cart[coupon_item][:clearance], count: 0}
      cart[coupon_item][:count] -= coupon_hash[:num]
      cart["#{coupon_item} W/COUPON"][:count] += 1
    end
  end
  cart
end

def apply_clearance(cart)
  cart.each do |item, info_hash|
    info_hash[:price] = (info_hash[:price] * 0.8).round(2) if info_hash[:clearance] == true
  end
  cart
end

def checkout(cart, coupons)
  cart = consolidate_cart(cart)
  cart = apply_coupons(cart, coupons)
  cart = apply_clearance(cart)
  total = 0
  cart.each do |item, info_hash|
    total += info_hash[:price] * info_hash[:count]
  end
  return (total * 0.9).round(2) if total > 100
  total
end
