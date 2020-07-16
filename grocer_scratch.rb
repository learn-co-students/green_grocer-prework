def apply_coupons(cart, coupons)
  coupon_hashes = {}

  cart.each do |item, values|
    coupons.each do |coupon|
      if item == coupon[:item]
        coupon_hashes["#{item} W/COUPON"] = {}
        coupon_hashes["#{item} W/COUPON"][:price] = coupon[:cost]
        coupon_hashes["#{item} W/COUPON"][:clearance] = cart[item][:clearance]
        coupon_hashes["#{item} W/COUPON"][:count] = cart[item][:count] / coupon[:num]
      end
    end
  end
  cart.merge(coupon_hashes)
end
